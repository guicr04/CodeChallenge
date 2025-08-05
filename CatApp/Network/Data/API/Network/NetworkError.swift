import Foundation

enum NetworkError {
  case invalidServerResponse
  case invalidURL
}

extension NetworkError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .invalidServerResponse:
      return "The server returned an invalid response."
    case .invalidURL:
      return "The URL is invalid."
    }
  }
}
