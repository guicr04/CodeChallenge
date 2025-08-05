
import Foundation

struct CatAPIService {
    private let requestManager: RequestManagerProtocol
    
    init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }
}

extension CatAPIService: CatsFetcher {
    func fetchBreeds(page: Int) async -> [Cat] {
        let requestData = CatsRequest.fetchCats(page)
        do {
            let cats: [Cat] = try await requestManager.perform(requestData)
            return cats
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
