
struct CatsFetcherMock: CatsFetcher {
    var mockBreeds: [Cat]

    func fetchBreeds(page: Int) async -> [Cat] {
        mockBreeds
    }
}
