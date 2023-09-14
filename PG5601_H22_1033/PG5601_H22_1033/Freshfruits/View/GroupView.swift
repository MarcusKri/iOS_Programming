import SwiftUI
import CoreData

struct GroupView: View {
    @SectionedFetchRequest<String, DbFruit>(sectionIdentifier: \.family!, sortDescriptors: [
        SortDescriptor(\.family),
        SortDescriptor(\.name),
    ])
    private var families: SectionedFetchResults
    
    var body: some View {
        
        //Grid two items
        let grid = [GridItem(.flexible()), GridItem(.flexible())]
        
        NavigationView {
            List {
                if DataModel.myShared.countFruits() == 0 {
                    Text("Kan ikke gruppere frukt, \nDu har ikke importert frukt 🍩")
                }
                ForEach(families) {
                    
                    family in
                    
                    Text(family.id).font(.title3)
                        .listRowSeparator(.hidden)
                    
                    ScrollView{
                        //LazyVGrid reach out to; let grid
                        LazyVGrid(columns: grid) {
                            ForEach(family) {
                                fruit in
                                
                                NavigationLink {
                                    DetailView(fruit: fruit)
                                } label: {
                                    VStack {
                                        Text(fruit.name ?? "Ukjent")
                                        Spacer()
                                        Text(fruit.order ?? "Ukjent")
                                    }
                                    .foregroundColor(.black)
                                    .fixedSize(horizontal: true, vertical: true)
                                    .frame(width: 150, height: 70)
                                    .background(
                                        LinearGradient(gradient: Gradient(colors: [.green, .orange]), startPoint: .leading, endPoint: .trailing)
                                            .cornerRadius(15)
                                    )
                                }
                            }
                        }
                        //Underline
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: 1)
                            .foregroundColor(.gray)
                            .opacity(0.5)
                    }
                }
            }
            .listStyle(.plain)
        }
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView().environment(\.managedObjectContext, DataModel.myShared.myContext)
    }
}
