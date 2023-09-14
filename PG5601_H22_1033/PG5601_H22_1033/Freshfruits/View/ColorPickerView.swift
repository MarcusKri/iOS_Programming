import SwiftUI
import CoreData

struct ColorPickerView: View {
    @Binding var family: Family
    @State var color = Color.blue
    
    var body: some View {
        ScrollView {
            VStack() {
                Form {
                    Section(header: Text("Fargevalg")) {
                        HStack {
                            Text("\(family.familyName) farge")
                            Spacer()
                            ColorPicker("Velg farge", selection: $color).labelsHidden().onDisappear {
                                family.familyColor = color.ColorToHex()
                            }
                        }
                    }
                }
                .frame(height: 100)
                
                Spacer()
                
                //Current color rectangle example
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(color)
                        .frame(width: 120, height: 120)
                        .border(.black, width: 4)
                        .cornerRadius(10)
                    
                }
                
                //Color value
                HStack {
                    Text("\nHEX verdi: #\(color.ColorToHex())")
                }
                
                Spacer()
            }
            .onAppear {
                color = Color(hex: family.familyColor)!
            }
            .padding()
        }
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView(family: .constant(colorExample))
    }
}
