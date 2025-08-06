import SwiftUI


struct CatListView: View {
    @StateObject private var viewModel = BreedListViewModel(catsFetcher: CatAPIService(requestManager: RequestManager()))
    @State private var selectedBreed: Cat? = nil

    var body: some View {
        NavigationView {
            VStack {
                Group {
                    switch viewModel.currentTab {
                    case .list:
                        CatListContent(viewModel: viewModel, selectedBreed: $selectedBreed)
                    case .favourites:
                        FavouritesView(viewModel: viewModel)
                    }
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
            .task {
                await viewModel.fetchBreeds()
            }
        }
    }
}
#Preview {
    CatListView()
}
