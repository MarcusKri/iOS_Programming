import SwiftUI

struct ImportView: View {
    @StateObject var json = JsonModel()
    
    //Confirmed
    @State var isConfirmed = false
    
    //Completed
    @State var isCompleted = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ShowHeader
            
            List {
                ShowFruit
            }
            .listStyle(.plain)
            .task {
                await json.loadFruits()
            }
            Spacer()
        }
        .padding()
    }
}

extension ImportView {
    private var ShowHeader: some View {
        Group {
            Text("Trykk for å importere frukten til hjem-skjermen.")
            
            HStack {
                Text("Hentet fra:")
                Link((url), destination: URL(string: url)!)
            }
            
            Button("Importer") {
                isConfirmed = true
            }
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [.green, .orange]), startPoint: .leading, endPoint: .trailing)
            )
            .foregroundColor(.black)
            .clipShape(Capsule())
            
            .confirmationDialog("Importer", isPresented: $isConfirmed) {
                Button("Bekreft") {
                    for index in 0...json.fruits.count - 1 {
                        DataModel.myShared.addFruit(fruit: json.fruits[index])
                    }
                    
                    DataModel.myShared.save()
                    
                    isCompleted = true
                }
                
                Button("Avbryt", role: .cancel) {}
            }
            .alert("Innholdet fra tabellen ble importert", isPresented: $isCompleted) {
                Button("OK", role: .cancel) {}
            }
            
            Text("\nFrukt importert: \(DataModel.myShared.countFruits())")
        }
    }
    
    private var ShowFruit: some View {
        ForEach(json.fruits) {
            fruit in
            
            VStack(alignment: .leading) {
                HStack {
                    Text("#\(fruit.id): \(fruit.name)").font(.headline)
                    Spacer()
                }
                Text("\(fruit.family) / \(fruit.genus) / \(fruit.order)\n").font(.subheadline)
                
                HStack {
                    Text("Karbohydrater: \(fruit.nutritions.carbohydrates, specifier: "%.1f")g")
                    Spacer()
                    Text("Kalorier: \(fruit.nutritions.calories, specifier: "%.1f")g")
                }
                
                HStack {
                    Text("Proteiner: \(fruit.nutritions.protein, specifier: "%.1f")g")
                    Spacer()
                    Text("Fett: \(fruit.nutritions.fat, specifier: "%.1f")g")
                }
                
                     Text("Sukker: \(fruit.nutritions.sugar, specifier: "%.2f")g")
                
                
                
            }
            .padding()
            .listRowSeparator(.hidden)
            .background(
                LinearGradient(gradient: Gradient(colors: [.green, .orange]), startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(15)
        }
    }
}

struct ImportView_Previews: PreviewProvider {
    static var previews: some View {
        ImportView()
    }
}
