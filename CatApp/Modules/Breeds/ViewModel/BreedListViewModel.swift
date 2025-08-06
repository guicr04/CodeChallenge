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
        let validBreeds = breeds.filter { $0.image?.url != nil} // just cats with a valid url will be shown
        if searchText.isEmpty {
            return validBreeds
        } else {
            return breeds.filter {
                ($0.name ?? "").lowercased().contains(searchText.lowercased()) // filter cats by the words on the searchbar 
            }
        }
    }
    
    var averageFavouriteLifespan: Double {
        let lifespans = breeds
            .filter { favourites.contains($0.id) }
            .compactMap { $0.lifeSpan } // ex: "12 - 15"
            .compactMap { $0.components(separatedBy: " - ").first } // just the lower value
            .compactMap { Double($0.trimmingCharacters(in: .whitespaces)) }

        guard !lifespans.isEmpty else { return 0 }
        let sum = lifespans.reduce(0, +)
        return sum / Double(lifespans.count)
    }
    
    enum Tab {
        case list
        case favourites
    }
    @Published var currentTab: Tab = .list
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
