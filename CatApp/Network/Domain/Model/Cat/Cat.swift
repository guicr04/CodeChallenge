typealias Cats = [Cat]

// MARK: - Cat

struct Cat: Decodable, Identifiable {
  let weight: Weight?
  let id: String?
  let name: String?
  let cfaURL: String?
  let vetstreetURL: String?
  let vcahospitalsURL: String?
  let temperament: String?
  let origin: String?
  let countryCodes: String?
  let countryCode: String?
  let description: String?
  let lifeSpan: String?
  let indoor, lap: Int?
  let altNames: String?
  let adaptability: Int?
  let affectionLevel: Int?
  let childFriendly: Int?
  let dogFriendly: Int?
  let energyLevel: Int?
  let grooming: Int?
  let healthIssues: Int?
  let intelligence: Int?
  let sheddingLevel: Int?
  let socialNeeds: Int?
  let strangerFriendly: Int?
  let vocalisation: Int?
  let experimental: Int?
  let hairless: Int?
  let natural: Int?
  let rare: Int?
  let rex: Int?
  let suppressedTail: Int?
  let shortLegs: Int?
  let wikipediaURL: String?
  let hypoallergenic: Int?
  let referenceImageID: String?
  let image: CatImage?
}

// MARK: - Weight

struct Weight: Decodable {
  let imperial: String?
  let metric: String?
}

// MARK: - CatImage

struct CatImage: Decodable {
    let id: String?
    let width, height: Int?
    let url: String?
}

// MARK: - Hashable

extension Cat: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

  static func == (lhs: Cat, rhs: Cat) -> Bool {
    lhs.id == rhs.id
  }
}
