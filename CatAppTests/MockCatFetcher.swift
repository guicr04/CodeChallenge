import Foundation
@testable import CatApp

class MockCatFetcher: CatsFetcher {
    var catsToReturn: [Cat] = []

    func fetchBreeds(page: Int) async -> [Cat] {
        return catsToReturn
    }
}
