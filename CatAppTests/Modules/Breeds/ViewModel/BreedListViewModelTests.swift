import XCTest
import CoreData
@testable import CatApp

@MainActor
final class BreedListViewModelTests: XCTestCase {

    var inMemoryContext: NSManagedObjectContext!
    var storage: CatStorageService!

    override func setUp() {
        super.setUp()

        // Cria NSPersistentContainer com armazenamento inMemory
        let container = NSPersistentContainer(name: "CatModel")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("❌ Failed to load inMemory CoreData store: \(error)")
            }
        }

        inMemoryContext = container.viewContext
        storage = CatStorageService(context: inMemoryContext)
    }


    func testFetchBreeds_setsBreedsAndStopsLoading() async {
        let expectedBreeds = [
            CatTestFactory.make(id: "1", name: "Abyssinian", imageURL: "https://example.com/image1.jpg"),
            CatTestFactory.make(id: "2", name: "Bengal", imageURL: "https://example.com/image2.jpg")
        ]
        let mockFetcher = CatsFetcherMock(mockBreeds: expectedBreeds)
        let viewModel = BreedListViewModel(catsFetcher: mockFetcher, storageService: storage)

        await viewModel.fetchBreeds()

        XCTAssertEqual(viewModel.breeds, expectedBreeds)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.hasMoreBreeds)
    }

    func testFetchMoreBreeds_incrementsPage() async {
        let mockFetcher = CatsFetcherMock(mockBreeds: [])
        let viewModel = BreedListViewModel(catsFetcher: mockFetcher, storageService: storage)

        XCTAssertEqual(viewModel.page, 0)
        await viewModel.fetchMoreBreeds()
        XCTAssertEqual(viewModel.page, 1)
    }

    func testSearchFiltersBreedsCorrectly() async {
        let expectedBreeds = [
            CatTestFactory.make(id: "1", name: "Abyssinian", imageURL: "https://example.com/image1.jpg"),
            CatTestFactory.make(id: "2", name: "Bengal", imageURL: "https://example.com/image2.jpg")
        ]
        let mockFetcher = CatsFetcherMock(mockBreeds: expectedBreeds)
        let viewModel = BreedListViewModel(catsFetcher: mockFetcher, storageService: storage)

        await viewModel.fetchBreeds()
        viewModel.searchText = "abys"

        XCTAssertEqual(viewModel.filteredBreeds.count, 1)
        XCTAssertEqual(viewModel.filteredBreeds.first?.name, "Abyssinian")
    }

    func testAverageFavouriteLifespan() async {
        let mockBreeds = [
            CatTestFactory.make(id: "1", name: "Abyssinian", lifeSpan: "10 - 15", imageURL: "https://example.com/image1.jpg"),
            CatTestFactory.make(id: "2", name: "Bengal", lifeSpan: "12 - 14", imageURL: "https://example.com/image2.jpg")
        ]
        let mockFetcher = CatsFetcherMock(mockBreeds: mockBreeds)
        let viewModel = BreedListViewModel(catsFetcher: mockFetcher, storageService: storage)

        await viewModel.fetchBreeds()
        viewModel.toggleFavourite(breed: mockBreeds[0])
        viewModel.toggleFavourite(breed: mockBreeds[1])

        let expectedAverage = (10 + 12) / 2.0
        XCTAssertEqual(viewModel.averageFavouriteLifespan, expectedAverage)
    }
}
