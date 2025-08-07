typealias Cats = [Cat]


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

struct Weight: Decodable {
  let imperial: String?
  let metric: String?
}

struct CatImage: Decodable {
    let id: String?
    let width, height: Int?
    let url: String?
}

extension Cat: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

  static func == (lhs: Cat, rhs: Cat) -> Bool {
    lhs.id == rhs.id
  }
}


extension Cat {
    init(from entity: CatEntity) {
        self.weight = nil
        self.id = entity.id
        self.name = entity.name
        self.cfaURL = nil
        self.vetstreetURL = nil
        self.vcahospitalsURL = nil
        self.temperament = entity.temperament
        self.origin = entity.origin
        self.countryCodes = nil
        self.countryCode = nil
        self.description = entity.desc
        self.lifeSpan = nil
        self.indoor = nil
        self.lap = nil
        self.altNames = nil
        self.adaptability = nil
        self.affectionLevel = nil
        self.childFriendly = nil
        self.dogFriendly = nil
        self.energyLevel = nil
        self.grooming = nil
        self.healthIssues = nil
        self.intelligence = nil
        self.sheddingLevel = nil
        self.socialNeeds = nil
        self.strangerFriendly = nil
        self.vocalisation = nil
        self.experimental = nil
        self.hairless = nil
        self.natural = nil
        self.rare = nil
        self.rex = nil
        self.suppressedTail = nil
        self.shortLegs = nil
        self.wikipediaURL = nil
        self.hypoallergenic = nil
        self.referenceImageID = nil
        self.image = CatImage(id: nil, width: nil, height: nil, url: entity.imageURL)
    }
}
