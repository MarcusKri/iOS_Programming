import SwiftUI

struct FreshfruitsView: View {
    var body: some View {
        VStack {
            //LOGO
            Image("Logo").resizable().scaledToFit().frame(height: 100)
            
            TabView {
                
                //Home
                HomeView().tabItem {
                    Label("Hjem", systemImage: "house.fill")
                }
                
                //Group
                GroupView().tabItem {
                    Label("Gruppering", systemImage: "rectangle.3.group.fill")
                }
                
                //Record
                RecordView().tabItem {
                    Label("Logg", systemImage: "chart.bar.doc.horizontal")
                }
                
                //Settings
                SettingsView().tabItem {
                    Label("Innstillinger", systemImage: "gearshape.fill")
                }
            }
        }
    }
}

struct FreshfruitsView_Previews: PreviewProvider {
    static var previews: some View {
        FreshfruitsView().environment(\.managedObjectContext, DataModel.myShared.myContext)
    }
}
