import CoreData

final class CatStorageService {
    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }

    func saveCats(_ cats: [Cat]) {
        for cat in cats {
            guard let id = cat.id,
                  let name = cat.name,
                  let imageUrl = cat.image?.url else { continue }

            let request: NSFetchRequest<CatEntity> = CatEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", id)
            
            let existing = try? context.fetch(request).first
            let entity = existing ?? CatEntity(context: context)

            entity.id = id
            entity.name = cat.name
            entity.origin = cat.origin
            entity.temperament = cat.temperament
            entity.desc = cat.description
            entity.imageURL = imageUrl
            // isFavourite stays untouched if already exists
        }

        do {
            try context.save()
        } catch {
            print("Error saving cats to CoreData: \(error)")
        }
    }

    func fetchAllCats() -> [CatEntity] {
        let request: NSFetchRequest<CatEntity> = CatEntity.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }

    func fetchCat(by id: String) -> CatEntity? {
        let request: NSFetchRequest<CatEntity> = CatEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1
        return (try? context.fetch(request))?.first
    }

    func toggleFavourite(for id: String) {
        guard let cat = fetchCat(by: id) else { return }
        cat.isFavourite.toggle()
        try? context.save()
    }

    func updateFavourites(for id: String) {
        let request: NSFetchRequest<CatEntity> = CatEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", id)

        do {
            if let entity = try context.fetch(request).first {
                entity.isFavourite.toggle()
                try context.save()
            }
        } catch {
            print("Error updating favourite: \(error)")
        }
    }
    
    func fetchFavouriteCatIDs() -> Set<String> {
        let request: NSFetchRequest<CatEntity> = CatEntity.fetchRequest()
        request.predicate = NSPredicate(format: "isFavourite == YES")

        do {
            let results = try context.fetch(request)
            return Set(results.compactMap { $0.id })
        } catch {
            print("Error fetching favourites from CoreData: \(error)")
            return []
        }
    }
}
