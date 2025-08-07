import SwiftUI

struct CatListContent: View {
    @ObservedObject var viewModel: BreedListViewModel
    @Binding var selectedBreed: Cat?

    var body: some View {
        VStack {
            TextField("Search", text: $viewModel.searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            ScrollView {
                LazyVGrid(
                    columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ],
                    spacing: 12
                ) {
                    ForEach(viewModel.filteredBreeds.indices, id: \.self) { index in
                        let breed = viewModel.filteredBreeds[index]

                        CatTileView(
                            breed: breed,
                            isFavourite: viewModel.favourites.contains(breed.id),
                            toggleFavourite: {
                                viewModel.toggleFavourite(breed: breed)
                            }
                        )
                        .onTapGesture {
                            selectedBreed = breed
                        }
                        .onAppear {
                            if index == viewModel.filteredBreeds.count - 1 {
                                Task {
                                    await viewModel.fetchMoreBreeds()
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }

            HStack {
                Spacer()
                Text("Cats list")
                    .fontWeight(.bold)
                Spacer()
                Spacer()
                Button("Favourites") {
                    viewModel.currentTab = .favourites
                }.accessibilityIdentifier("favouritesTab")
                
                Spacer()
            }
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
        }
    }
}
