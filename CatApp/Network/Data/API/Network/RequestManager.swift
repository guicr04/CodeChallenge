protocol RequestManagerProtocol {
  func perform<Element: Decodable>(_ request: RequestProtocol) async throws -> Element
}


final class RequestManager {

  private let apiManager: APIManagerProtocol
  private let parser: DataParserProtocol

  init(
    apiManager: APIManagerProtocol = APIManager(),
    parser: DataParserProtocol = DataParser()
  ) {
    self.apiManager = apiManager
    self.parser = parser
  }
}

extension RequestManager: RequestManagerProtocol {
  func perform<Element: Decodable>(_ request: RequestProtocol) async throws -> Element {
    let data = try await apiManager.perform(request)
    let decoded: Element = try parser.parse(data: data)
    return decoded
  }
}
