import SwiftUI

struct DeleteView: View {
    
    //Confirmed
    @State var isConfirmed = false
    
    //Completed
    @State var isCompleted = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Trykk på knappen for å tømme innholdet. ")
            
            Text("\nFrukt importert: \(DataModel.myShared.countFruits())")
            Text("Inntak av frukt: \(DataModel.myShared.countEvents())")
            
            Button("Tøm database", role: .destructive) {
                isConfirmed = true
            }
            .buttonStyle(.borderedProminent)
            .clipShape(Capsule())
            
            .confirmationDialog("Tøm database", isPresented: $isConfirmed) {
                Button("Trykk her for å bekrefte", role: .destructive) {
                    DataModel.myShared.deleteAllFruits()
                    isCompleted = true
                }
                
                Button("Avbryt", role: .cancel) {}
            }
            .alert("Innholdet i databasen er slettet", isPresented: $isCompleted) {
                Button("OK", role: .cancel) {}
            }
            Spacer()
        }
        .padding()
    }
}

struct DeleteView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteView()
    }
}
