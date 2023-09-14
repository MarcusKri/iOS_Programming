import SwiftUI

struct ColorView: View {
    // Retrieves all groups from DbFruit and copies to a table or array
    @State var families: [Family] = DataModel.myShared.groupFamilies()
    
    //Confirmed
    @State var isConfirmed = false
    
    //Completed
    @State var isCompleted = false
    
    var body: some View {
            NavigationView {
                    List {
                        if DataModel.myShared.countFruits() == 0 {
                            Text("Kan ikke endre farge, \nDu har ikke importert frukt 🍩")
                        } else {
                        ShowHeader
                        ShowFamily
                    }
                }
                .listStyle(.plain)
            }
        .padding()
    }
}

extension ColorView {
    private var ShowHeader: some View {
        Group {
            Text("Endre farge på familie-boksene, deretter lagre.")
            
            Button("Lagre farger") {
                isConfirmed = true
            }
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [.mint, .green, .yellow, .orange]), startPoint: .leading, endPoint: .trailing)
            )
            .foregroundColor(.black)
            .clipShape(Capsule())
            .confirmationDialog("Lagre fargevalg", isPresented: $isConfirmed) {
                Button("Trykk her for å bekrefte") {
                    DataModel.myShared.saveFamilyColors(families: families)
                    isCompleted = true
                }
                
                Button("Avbryt", role: .cancel) {}
            }
            .alert("Fargevalgene er lagret", isPresented: $isCompleted) {
                Button("OK", role: .cancel) {}
            }
        }
    }
    
    private var ShowFamily: some View {
        ForEach($families, id: \.self) {
            $family in
            
            NavigationLink {
                ColorPickerView(family: $family)
            } label: {
                HStack {
                    Text(family.familyName)
                    Spacer()
                    Rectangle()
                        .fill(Color(hex: family.familyColor)!.gradient)
                        .frame(width: 35, height: 35)
                        .border(.black, width: 0.7)
                }
            }
            .listRowSeparator(.hidden)
            .padding(15)
            .background(
                LinearGradient(gradient: Gradient(colors: [.mint, .green, .yellow, .orange]), startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(15)
        }
    }
}

struct ColorView_Previews: PreviewProvider {
    static var previews: some View {
        ColorView().environment(\.managedObjectContext, DataModel.myShared.myContext)
    }
}
