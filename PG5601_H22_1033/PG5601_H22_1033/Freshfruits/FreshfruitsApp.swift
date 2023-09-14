import SwiftUI

@main

struct FreshfruitsApp: App {
    // A property wrapper that reads one of many properties of the view
    @Environment(\.scenePhase) var myScene
    
    var body: some Scene {
        WindowGroup {
            // Creates one instance of the database
            let datamodel = DataModel.myShared
            
            // Opens the main window and ensures that the data model is available down through all views
            FreshfruitsView().environment(\.managedObjectContext, datamodel.myContext)
        }
        .onChange(of: myScene) {
            myScene in
            
            // Saves changes
            DataModel.myShared.save()
        }
    }
}
