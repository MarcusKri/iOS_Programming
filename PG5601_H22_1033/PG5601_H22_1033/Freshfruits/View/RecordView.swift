import SwiftUI

struct RecordView: View
{
    
    //Fetch DbEvent
    @FetchRequest( sortDescriptors: [
        SortDescriptor(\.date, order: .reverse)
    ])
    private var events: FetchedResults<DbEvent>
    
    
    var body: some View {
        List {
            //Checks how many times fruit is eaten
            Section("Inntak") {
                if DataModel.myShared.countEvents() == 0 {
                    Text("Du har ikke spist noe frukt 🍩")
                }
                else if DataModel.myShared.countEvents() == 1 {
                    Text("Du har spist \(DataModel.myShared.countEvents()) gang")
                } else {
                    Text("Du har spist \(DataModel.myShared.countEvents()) ganger")
                }
            }
            
            ForEach(events) {
                event in
                
                //Gets the date and time
                Section("\(event.date!, style: .date). \(event.date!, style: .time)") {
                    Text(event.oneFruit!.name ?? "").font(Font.headline.weight(.bold)) //bold font
                    Text("Karbohydrater: \(event.oneFruit!.carbohydrates, specifier: "%.1f")g")
                    Text("Kalorier: \(event.oneFruit!.calories, specifier: "%.1f")g")
                    Text("Proteiner: \(event.oneFruit!.protein, specifier: "%.1f")g")
                    Text("Fett: \(event.oneFruit!.fat, specifier: "%.1f")g")
                    Text("Sukker: \(event.oneFruit!.sugar, specifier: "%.1f")g")
                }
            }
        }
    }
}



struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView().environment(\.managedObjectContext, DataModel.myShared.myContext)
    }
}
