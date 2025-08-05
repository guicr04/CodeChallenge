enum CatsRequest {
  case fetchCats(_ page: Int)
}

extension CatsRequest: RequestProtocol {
  var path: String {
    "/v1/breeds"
  }

  var urlParams: [String: String?] {
    switch self {
    case let .fetchCats(page):
      return [
        "api_key": APIConstants.apiKey,
        "limit": String(10),
        "page": String(page)
      ]
    }
  }

  var requestType: RequestType {
    .GET
  }
}
