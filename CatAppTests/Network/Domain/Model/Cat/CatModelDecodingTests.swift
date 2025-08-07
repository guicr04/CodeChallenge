import XCTest
@testable import CatApp

final class CatModelDecodingTests: XCTestCase {

    func testCatDecoding_fromValidJSON() throws {
        let json = """
        {
            "id": "abys",
            "name": "Abyssinian",
            "life_span": "14 - 15",
            "image": {
                "url": "https://example.com/image.jpg"
            }
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let cat = try decoder.decode(Cat.self, from: json)

        XCTAssertEqual(cat.id, "abys")
        XCTAssertEqual(cat.name, "Abyssinian")
        XCTAssertEqual(cat.lifeSpan, "14 - 15")
        XCTAssertEqual(cat.image?.url, "https://example.com/image.jpg")
    }

    func testCatDecoding_fromInvalidJSON() throws {
        let json = "{}".data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let cat = try decoder.decode(Cat.self, from: json)
        XCTAssertNil(cat.id)
        XCTAssertNil(cat.name)
    }
}
