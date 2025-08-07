import XCTest

final class CatFavouritesUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testEmptyFavouritesMessageAppears() throws {
        // Click favourites button
        app.buttons["favouritesTab"].tap()

        // Checks if text is visible
        let noFavouritesText = app.staticTexts["noFavouritesText"]
        XCTAssertTrue(noFavouritesText.waitForExistence(timeout: 2), "Expected 'No favourites yet' to appear")
    }
    
    func testAddAndRemoveFavouriteFlow() throws {
        // Tap the first cat in the list
        let firstCatTile = app.staticTexts["catTile"].firstMatch
        XCTAssertTrue(firstCatTile.waitForExistence(timeout: 3), "First cat tile not found")
        firstCatTile.tap()

        // Tap the favourite (star) button
        let favouriteButton = app.buttons["favouriteButton"]
        XCTAssertTrue(favouriteButton.waitForExistence(timeout: 2), "Favourite button not found")
        favouriteButton.tap()

        // Dismiss the modal (sheet)
        let start = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.1)) // Top
        let end = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.9))   // Bottom
        start.press(forDuration: 0.5, thenDragTo: end)

        // Switch to the favourites tab
        app.buttons["favouritesTab"].tap()

        // Confirm that the cat appears in favourites
        let catTileInFavourites = app.scrollViews.buttons.firstMatch

        // remove favourite
        catTileInFavourites.tap()
         

        // Confirm that "No favourites yet" appears again
        let noFavouritesText = app.staticTexts["noFavouritesText"]
        XCTAssertTrue(noFavouritesText.waitForExistence(timeout: 3), "No favourites message should appear after removal")
    }
}
