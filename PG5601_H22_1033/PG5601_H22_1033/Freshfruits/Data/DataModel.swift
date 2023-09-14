import Foundation
import CoreData

// STRUCT gets all family categories
struct Family: Hashable {
    let familyName: String
    var familyColor: String
}

let colorExample = Family(familyName: "Apple", familyColor: "008800")

// Datamodel
final class DataModel {
    // Singleton
    static let myShared = DataModel()
    // Savingspace for core data
    private var myContainer: NSPersistentContainer
    
    init() {
        myContainer = NSPersistentContainer(name: "Database")
        
        myContainer.loadPersistentStores {
            (description, error) in
            
            if let myError = error as NSError? {
                print("Beklager, men kan ikke åpne databasen.\n\(myError), \(myError.userInfo)")
            }
        }
    }
    
    var myContext: NSManagedObjectContext {
        myContainer.viewContext
    }
    
    // Save to database
    func save() {
        if myContext.hasChanges {
            do {
                try myContext.save()
            }
            catch {
                print("Beklager, men kan ikke lagre endringer.\n\(error), \(error.localizedDescription)")
            }
        }
    }
    
    // New fruit to database
    func addFruit(fruit: JsFruit) {
        let myFruit = DbFruit(context: myContext)
        
        myFruit.id = UUID()
        myFruit.name = fruit.name
        myFruit.family = fruit.family
        myFruit.genus = fruit.genus
        myFruit.order = fruit.order
        myFruit.carbohydrates = fruit.nutritions.carbohydrates
        myFruit.calories = fruit.nutritions.calories
        myFruit.protein = fruit.nutritions.protein
        myFruit.sugar = fruit.nutritions.sugar
        myFruit.fat = fruit.nutritions.fat
    }
    
    // Deletes all fruit in database
    func deleteAllFruits() {
        let myRequest = DbFruit.fetchRequest()
        
        let fruits = try? myContext.fetch(myRequest)
        for fruit in fruits ?? [] {
            myContext.delete(fruit)
        }
        save()
    }
    
    // Count fruits in DbFruit
    func countFruits() -> Int {
        let myRequest = DbFruit.fetchRequest()
        
        let fruits = try? myContext.fetch(myRequest)
        return fruits?.count ?? -1
    }
    
    // Count events in DbEvent
    func countEvents() -> Int {
        let myRequest = DbEvent.fetchRequest()
        
        let events = try? myContext.fetch(myRequest)
        return events?.count ?? -1
    }
    
    // Family category with color
    func groupFamilies() -> [Family] {
        let myRequest = DbFruit.fetchRequest()
        
        let sortFamily = NSSortDescriptor(keyPath: \DbFruit.family, ascending: true)
        let sortName = NSSortDescriptor(keyPath: \DbFruit.name, ascending: true)
        myRequest.sortDescriptors = [sortFamily, sortName]
        
        let fruits = try? myContext.fetch(myRequest)
        
        var families: [Family] = []
        var familyName: String = ""
        var familyColor: String
        
        for fruit in fruits ?? [] {
            if fruit.family != familyName {
                familyName = fruit.family ?? "Ukjent"
                familyColor = fruit.color ?? "00FF00"
                
                families.append(Family(familyName: familyName, familyColor: familyColor))
            }
        }
        return families
    }
    
    // Saves color choice to family category
    func saveFamilyColors(families: [Family]) {
        let myRequest = DbFruit.fetchRequest()
        
        let fruits = try? myContext.fetch(myRequest)
        
        for fruit in fruits ?? [] {
            for family in families {
                if family.familyName == fruit.family {
                    
                    fruit.color = family.familyColor
                }
            }
            save()
        }
    }
    
    // Add event
    func addEvent(fruit: DbFruit) {
        let myEvent = DbEvent(context: myContext)
        
        myEvent.id = UUID()
        myEvent.date = Date()
        myEvent.number = 1
        
        fruit.addToManyEvents(myEvent)
        
        save()
    }
}
