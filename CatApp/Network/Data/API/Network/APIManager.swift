import Foundation


protocol APIManagerProtocol {
  func perform(_ request: RequestProtocol) async throws -> Data
}

final class APIManager {

  private let urlSession: URLSession

  init(urlSession: URLSession = URLSession.shared) {
    self.urlSession = urlSession
  }
}

extension APIManager: APIManagerProtocol {
  func perform(_ request: RequestProtocol) async throws -> Data {
    let (data, response) = try await urlSession.data(for: request.createURLRequest())
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200
    else {
      throw NetworkError.invalidServerResponse
    }
    return data
  }
}
