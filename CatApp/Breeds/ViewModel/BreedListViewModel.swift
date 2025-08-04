import Foundation
import SwiftUI

@MainActor
class BreedListViewModel: ObservableObject {
    @Published var breeds: [Breed] = []
    @Published var favourites: Set<String> = []
    @Published var searchText: String = ""
    
    var filteredBreeds: [Breed] {
        if searchText.isEmpty {
            return breeds
        } else {
            return breeds.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func fetchBreeds() async {
        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([Breed].self, from: data)
            breeds = decoded
        } catch {
            print("Error fetching breeds: \(error.localizedDescription)")
        }
    }
    
    func toggleFavourite(breed: Breed) {
        if(favourites.contains(breed.id)) {
            favourites.remove(breed.id)
        } else {
            favourites.insert(breed.id)
        }
    }
}
