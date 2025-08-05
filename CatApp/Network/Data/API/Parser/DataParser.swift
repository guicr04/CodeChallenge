import Foundation

protocol DataParserProtocol {
  func parse<Element: Decodable>(data: Data) throws -> Element
}

final class DataParser {

  private let jsonDecoder: JSONDecoder

  init(jsonDecoder: JSONDecoder = JSONDecoder()) {
    self.jsonDecoder = jsonDecoder
    self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
  }
}

extension DataParser: DataParserProtocol {
  func parse<Element: Decodable>(data: Data) throws -> Element {
    return try jsonDecoder.decode(Element.self, from: data)
  }
}
