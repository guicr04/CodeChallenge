import Foundation

struct Breed: Identifiable, Decodable, Equatable, Hashable {
    let id: String
    let name: String
    let origin: String?
    let temperament: String?
    let description: String?
    let life_span: String?
    let image: BreedImage?
    
    struct BreedImage: Decodable, Hashable {
        let url: String
    }
}
