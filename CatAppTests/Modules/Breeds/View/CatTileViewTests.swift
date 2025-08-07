import XCTest
import ViewInspector
@testable import CatApp

final class CatTileViewTests: XCTestCase {

    func testTileDisplaysBreedName() throws {
        let view = CatTileView(
            breed: CatTestFactory.make(id: "1", name: "TestBreed", imageURL: "https://example.com/image.jpg"),
            isFavourite: true,
            toggleFavourite: {}
        )

        let text = try view.inspect().find(text: "TestBreed").string()
        XCTAssertEqual(text, "TestBreed")
    }

    func testTapToggleFavouriteCallsClosure() throws {
        var tapped = false
        let view = CatTileView(
            breed: CatTestFactory.make(id: "1", name: "TestBreed", imageURL: "https://example.com/image.jpg"),
            isFavourite: false,
            toggleFavourite: { tapped = true }
        )
        let button = try view.inspect().find(ViewType.Button.self)
        try button.tap()
        XCTAssertTrue(tapped)
    }
}
