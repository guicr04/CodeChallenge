import SwiftUI


struct CatListView: View {
    @StateObject private var viewModel = BreedListViewModel(catsFetcher: CatAPIService(requestManager: RequestManager()))
    @State private var selectedBreed: Cat? = nil

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("Search", text: $viewModel.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                // Grid of cat tiles
                ScrollView {
                    LazyVGrid(
                        columns :[
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ],
                        spacing: 12
                    ) {
                        ForEach(viewModel.filteredBreeds, id: \.id) { breed in
                            CatTileView(
                                breed: breed,
                                isFavourite: viewModel.favourites.contains(breed.id),
                                toggleFavourite: {
                                    viewModel.toggleFavourite(breed: breed)
                                }
                            )
                            .onTapGesture{
                                selectedBreed = breed
                            }
                        }
                    }
                        .padding(.horizontal, 16)
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
}

#Preview {
    CatListView()
}
