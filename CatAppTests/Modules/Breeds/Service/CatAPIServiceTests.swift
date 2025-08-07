import XCTest
@testable import CatApp

final class CatAPIServiceTests: XCTestCase {

    class MockRequestManager: RequestManagerProtocol {
        var shouldFail = false
        var mockCats: [Cat] = []

        func perform<T>(_ request: RequestProtocol) async throws -> T where T: Decodable {
            if shouldFail {
                throw URLError(.notConnectedToInternet)
            }
            return mockCats as! T
        }
    }

    func testFetchBreeds_success() async {
        let mockManager = MockRequestManager()
        mockManager.mockCats = [CatTestFactory.make(id: "abc", name: "Test", imageURL: "url")]
        let api = CatAPIService(requestManager: mockManager)

        let result = await api.fetchBreeds(page: 0)
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Test")
    }

    func testFetchBreeds_failureReturnsEmpty() async {
        let mockManager = MockRequestManager()
        mockManager.shouldFail = true
        let api = CatAPIService(requestManager: mockManager)

        let result = await api.fetchBreeds(page: 0)
        XCTAssertTrue(result.isEmpty)
    }
}
