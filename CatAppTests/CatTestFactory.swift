import Foundation
@testable import CatApp

enum CatTestFactory {
    static func make(
        id: String = UUID().uuidString,
        name: String = "Test Cat",
        lifeSpan: String? = nil,
        imageURL: String? = nil
    ) -> Cat {
        return Cat(
            weight: nil,
            id: id,
            name: name,
            cfaURL: nil,
            vetstreetURL: nil,
            vcahospitalsURL: nil,
            temperament: nil,
            origin: nil,
            countryCodes: nil,
            countryCode: nil,
            description: nil,
            lifeSpan: lifeSpan,
            indoor: nil,
            lap: nil,
            altNames: nil,
            adaptability: nil,
            affectionLevel: nil,
            childFriendly: nil,
            dogFriendly: nil,
            energyLevel: nil,
            grooming: nil,
            healthIssues: nil,
            intelligence: nil,
            sheddingLevel: nil,
            socialNeeds: nil,
            strangerFriendly: nil,
            vocalisation: nil,
            experimental: nil,
            hairless: nil,
            natural: nil,
            rare: nil,
            rex: nil,
            suppressedTail: nil,
            shortLegs: nil,
            wikipediaURL: nil,
            hypoallergenic: nil,
            referenceImageID: nil,
            image: imageURL != nil ? CatImage(id: nil, width: nil, height: nil, url: imageURL) : nil
        )
    }
}
