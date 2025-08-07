import XCTest
import CoreData
@testable import CatApp

final class CatStorageServiceTests: XCTestCase {

    var context: NSManagedObjectContext!
    var storage: CatStorageService!

    override func setUp() {
        super.setUp()
        let container = NSPersistentContainer(name: "CatModel")
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, _ in }
        context = container.viewContext
        storage = CatStorageService(context: context)
    }

    func testSaveCat_andFetchAll() {
        let cat = CatTestFactory.make(
            id: "123",
            name: "TestCat",
            lifeSpan: "10 - 15",
            imageURL: "https://example.com/cat.jpg"
        )
        storage.saveCats([cat])

        let cats = storage.fetchAllCats()
        XCTAssertEqual(cats.count, 1)
        XCTAssertEqual(cats.first?.id, "123")
    }

    func testToggleFavourite() {
        let cat = CatTestFactory.make(
            id: "123",
            name: "TestCat",
            lifeSpan: "10 - 15",
            imageURL: "https://example.com/cat.jpg"
        )
        storage.saveCats([cat])

        storage.updateFavourites(for: "123")
        let favourites = storage.fetchFavouriteCatIDs()
        XCTAssertTrue(favourites.contains("123"))

        storage.updateFavourites(for: "123")
        let updated = storage.fetchFavouriteCatIDs()
        XCTAssertFalse(updated.contains("123"))
    }
}
