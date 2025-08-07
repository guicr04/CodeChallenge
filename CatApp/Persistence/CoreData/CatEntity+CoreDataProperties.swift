//
//  CatEntity+CoreDataProperties.swift
//  CatApp
//
//  Created by Guilherme Castro Ribeiro on 06/08/2025.
//
//

import Foundation
import CoreData


extension CatEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CatEntity> {
        return NSFetchRequest<CatEntity>(entityName: "CatEntity")
    }

    @NSManaged public var desc: String?
    @NSManaged public var id: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var name: String?
    @NSManaged public var origin: String?
    @NSManaged public var temperament: String?
    @NSManaged public var isFavourite: Bool

}

extension CatEntity : Identifiable {

}
