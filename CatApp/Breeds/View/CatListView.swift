import SwiftUI


struct CatListView: View {
    @StateObject private var viewModel = BreedListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("Search", text: $viewModel.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                // Grid of cat tiles
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                        ForEach(viewModel.filteredBreeds, id: \.id) { breed in
                            CatTileView(
                                breed: breed.name,
                                isFavourite: viewModel.favourites.contains(breed.id),
                                toggleFavourite: {
                                    viewModel.toggleFavourite(breed: breed)
                                }
                            )
                        }
                    }
                }

                // Tab bar
                HStack {
                    Spacer()
                    Text("Cats list")
                        .fontWeight(.bold)
                    Spacer()
                    Spacer()
                    Text("Favourites")
                    Spacer()
                }
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
            }
            .task {
                await viewModel.fetchBreeds()
            }
            .navigationTitle("Cats App")
        }
    }
}

#Preview {
    CatListView()
}
