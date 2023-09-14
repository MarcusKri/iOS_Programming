import SwiftUI
import CoreData

struct HomeView: View {
    
    // Retrieves all fruits from DbFruit database, sorted by family and then name
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.family),
        SortDescriptor(\.name)
    ])
    
    private var fruits: FetchedResults<DbFruit>
    
    var body: some View {
        NavigationView {
            List {
                //Checks if fruit is imported
                if DataModel.myShared.countFruits() == 0 {
                    Text("Kan ikke hente frukt, \nDu har ikke importert frukt 🍩")
                } else {
                    ShowFruit
                }
            }
            .listStyle(.plain)
        }
    }
}

extension HomeView {
    private var ShowFruit: some View {
        ForEach(fruits) {
            fruit in
            
            NavigationLink {
                DetailView(fruit: fruit)
            }
        label: {
            VStack(alignment: .leading) {
                HStack {
                    Text(fruit.name ?? "Ukjent").font(.headline)
                }
                HStack {
                    Text("\(fruit.family ?? "")").font(.subheadline)
                    Spacer()
                    Rectangle()
                        .fill(Color(hex: fruit.color ?? "0000FF")!.gradient)
                        .frame(width: 35, height: 35)
                        .border(.black, width: 0.7)
                }
            }
            .padding(15)
            .background(
                LinearGradient(gradient: Gradient(colors: [.green, .orange]), startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(15)
        }
        .listRowSeparator(.hidden)
        }
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environment(\.managedObjectContext, DataModel.myShared.myContext)
    }
}
