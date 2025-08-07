import SwiftUI

struct FavouritesView: View {
    @ObservedObject var viewModel: BreedListViewModel
    @State private var selectedBreed: Cat? = nil

    var body: some View {
        let favouriteBreeds = viewModel.breeds.filter { viewModel.favourites.contains($0.id) && $0.image?.url != nil }
        VStack {
            // If the favourite view is empty shows info message
            if viewModel.averageFavouriteLifespan > 0 {
                Text("Average Lifespan: \(String(format: "%.1f", viewModel.averageFavouriteLifespan)) years")
                    .font(.subheadline)
                    .padding(.bottom, 8)
            }
            // Grid with favourites only
            ScrollView {
                if favouriteBreeds.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "star")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                        Text("No favourites yet")
                            .font(.headline)
                            .accessibilityIdentifier("noFavouritesText")
                        Text("Mark a cat as favourite to view it here.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 100)
                    .frame(maxWidth: .infinity)
                } else {
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ],
                        spacing: 12
                    ) {
                        ForEach(favouriteBreeds, id: \.id) { breed in
                            CatTileView(
                                breed: breed,
                                isFavourite: viewModel.favourites.contains(breed.id),
                                toggleFavourite: {
                                    viewModel.toggleFavourite(breed: breed)
                                }
                            )
                            .accessibilityIdentifier("catTile_\(breed.id ?? "unknown")")
                            .onTapGesture {
                                selectedBreed = breed
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                        
                }
            }

            // Tab bar
            HStack {
                Spacer()
                Button("Cats list") {
                    // Troca para lista principal
                    viewModel.currentTab = .list
                }
                Spacer()
                Spacer()
                Text("Favourites")
                    .fontWeight(.bold)
                    .accessibilityIdentifier("favouritesTab") //Identifier for tests
                Spacer()
            }
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
        }
        .sheet(item: $selectedBreed) { breed in
            BreedDetailSheet(
                breed: breed,
                isFavourite: viewModel.favourites.contains(breed.id),
                toggleFavourite: {
                    viewModel.toggleFavourite(breed: breed)
                }
            )
        }
    }
}
