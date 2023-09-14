import SwiftUI

struct EatView: View {
    
    let fruit: DbFruit
    
    @State var isPresentingDetailView = false
    @State var isPresentingHomeView = false
    
    @FetchRequest( sortDescriptors: [
        SortDescriptor(\.date, order: .reverse)
    ])
    private var events: FetchedResults<DbEvent>
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    HStack {
                        Text("\(fruit.name ?? "Ukjent navn")").font(.title)
                    }
                    
                    Section("Dato"){
                        Text("\(Date.now, format: .dateTime.day().month().year())")
                    }
                    
                    Section("Næringsinnhold per 100 gram") {
                        Text("Karbohydrater: \(fruit.carbohydrates, specifier: "%.1f")g")
                        Text("Kalorier: \(fruit.calories, specifier: "%.1f")g")
                        Text("Proteiner: \(fruit.protein, specifier: "%.1f")g")
                        Text("Fett: \(fruit.fat, specifier: "%.1f")g")
                        Text("Sukker: \(fruit.sugar, specifier: "%.1f")g")
                    }
                }
                
                Text("Du er i ferd med å spise \(fruit.name ?? "Ukjent")")
                
                
                //Cancel / record
                HStack(spacing: 5) {
                    Button("Avbryt", role: .destructive) {
                        isPresentingDetailView = true
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .clipShape(Capsule())
                    
                    NavigationLink(destination: DetailView(fruit: fruit).navigationBarBackButtonHidden(true),
                                   isActive: $isPresentingDetailView) { }
                    
                    Button("Loggfør") {
                        isPresentingHomeView = true
                        DataModel.myShared.addEvent(fruit: fruit)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .clipShape(Capsule())
                    .tint(.green)
                    
                    NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true),
                                   isActive: $isPresentingHomeView)
                    { }
                }
                
            }
            
        }
        
    }
}


struct EatView_Previews: PreviewProvider {
    
    static let myContext = DataModel.myShared.myContext
    
    static var previews: some View {
        
        let fruit = DbFruit(context: myContext)
        
        fruit.id = UUID()
        fruit.name = "Apple"
        fruit.family = "Rosaceae"
        fruit.genus = "Malus"
        fruit.order = "Rosales"
        fruit.carbohydrates = 11.4
        fruit.calories = 52
        fruit.protein = 0.3
        fruit.sugar = 10.3
        fruit.fat = 0.4
        
        return EatView(fruit: fruit)
    }
}
