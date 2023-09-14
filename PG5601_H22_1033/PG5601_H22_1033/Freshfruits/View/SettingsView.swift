import SwiftUI
import CoreData

struct SettingsView: View {
    
    var body: some View {
        NavigationView {
            List {
                
                //Import
                NavigationLink {
                    ImportView()
                } label: {
                    Label("Importer", systemImage: "square.and.arrow.down.fill")
                }
                
                //Family
                NavigationLink {
                    ColorView()
                } label: {
                    Label("Velg farge" , systemImage: "scribble.variable")
                }
                
                //Delete
                NavigationLink {
                    DeleteView()
                } label: {
                    Label("Slett", systemImage: "trash.fill")
                }
            }
            .listStyle(.plain)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
