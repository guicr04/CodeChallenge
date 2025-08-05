import Foundation
import SwiftUI

protocol CatsFetcher {
    func fetchBreeds(page: Int) async -> [Cat]
}

@MainActor
class BreedListViewModel: ObservableObject {
    @Published var breeds: [Cat] = []
    @Published var favourites: Set<String?> = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var hasMoreBreeds: Bool = true
    
    private let catsFetcher: CatsFetcher
    private(set) var page = 0
    
    init(isLoadind: Bool = false, catsFetcher: CatsFetcher) {
        self.isLoading = isLoadind
        self.catsFetcher = catsFetcher
    }
    
    var filteredBreeds: [Cat] {
        if searchText.isEmpty {
            return breeds
        } else {
            return breeds.filter {
                ($0.name ?? "").lowercased().contains(searchText.lowercased())
            }
        }
    }
}

extension BreedListViewModel {
    
    func fetchBreeds() async {
        guard !isLoading else { return }
        
        isLoading = true
        let newBreeds = await catsFetcher.fetchBreeds(page: page)
        
        breeds += newBreeds
        hasMoreBreeds = !newBreeds.isEmpty
        isLoading = false
    }
    
    func fetchMoreBreeds() async {
        guard hasMoreBreeds else { return }
        page += 1
        await fetchBreeds()
    }
    
    func toggleFavourite(breed: Cat) {
        if favourites.contains(breed.id) {
            favourites.remove(breed.id)
        } else {
            favourites.insert(breed.id)
        }
        
    }
}
