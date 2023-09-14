import SwiftUI
import CoreData

struct DetailView: View
{
    let fruit: DbFruit
    
    //Emoji array with animation
    let emoji = ["🍎", "🍊", "🍋", "🫐", "🍒"]
    @State private var isAnimated = false
    
    //Animate color
    @State private var color = Color.black
    
    //Redirect to CreateRecordView
    @State var isPresentingCreateRecordView = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                VStack {
                    List {
                        HStack {
                            Text("\(fruit.name ?? "Ukjent navn")").font(.title)
                            Spacer()
                            Text("Familie: \(fruit.family ?? "Ukjent")")
                        }
                        
                        Section("Slekt / rangering") {
                            Text("\(fruit.genus ?? "Ukjent") / \(fruit.order ?? "Ukjent")")
                        }
                        
                        Section("Næringsinnhold per 100 gram") {
                                Text("Karbohydrater: \(fruit.carbohydrates, specifier: "%.1f")g")
    
                                Text("Kalorier: \(fruit.calories, specifier: "%.1f")g")
                                Text("Proteiner: \(fruit.protein, specifier: "%.1f")g")
                                Text("Fett: \(fruit.fat, specifier: "%.1f")g")
                            
                            //Sugar with animation and a text if the sugar value is over 10
                            HStack {
                                Text("Sukker: \(fruit.sugar, specifier: "%.1f")g")
                                Spacer()
                                if fruit.sugar > 10 {
                                    Text("Høyt sukkernivå")
                                        .foregroundColor(Color.white)
                                        .colorMultiply(self.color)
                                        .onAppear {
                                            withAnimation(.easeInOut
                                                .delay(1)
                                                .repeatForever()
                                            ) {
                                                self.color = Color.red
                                            }
                                        }
                                }
                            }
                        }
                    }

                    
                    //Button with redirect to CreateRecordView
                    VStack {
                        Text("Ønsker du å spise \(fruit.name ?? "Ukjent navn")?")
                        Button("Gå videre") {
                            isPresentingCreateRecordView.toggle()
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .clipShape(Capsule())
                        .tint(.green)
                        
                        NavigationLink(destination: EatView(fruit: fruit).navigationBarBackButtonHidden(true),
                                       isActive: $isPresentingCreateRecordView)
                        { }
                    }
                }
                
                //Gets the Text "🍩" if its clicked 0 times
                if DataModel.myShared.countEvents() == 0 {
                    Text("🍩").offset(y: isAnimated ? 500 : -500)
                        .font(isAnimated ? .title3 : .title)
                        .onAppear {
                            withAnimation(Animation
                                .timingCurve(0.2, 0.2, 0.2, 0.2)
                                .speed(0.1)
                                .delay(1)
                                .repeatForever(autoreverses: false)
                            )
                            {
                                isAnimated.toggle()
                            }
                        }
                }
                
                //Prints the first element if its clicked 1 time
                else if DataModel.myShared.countEvents() == 1 {
                    Text(emoji[0]).offset(y: isAnimated ? 500 : -500)
                        .font(isAnimated ? .title3 : .title)
                        .onAppear {
                            withAnimation(Animation
                                .timingCurve(0.2, 0.2, 0.2, 0.2)
                                .speed(0.1)
                                .delay(1)
                                .repeatForever(autoreverses: false)
                            )
                            {
                                isAnimated.toggle()
                            }
                        }
                }
                
                //Prints the first and second element if its clicked 2 time
                else if DataModel.myShared.countEvents() == 2 {
                    Text(emoji[0] + emoji[1]).offset(y: isAnimated ? 500 : -500)
                        .font(isAnimated ? .title3 : .title)
                        .onAppear {
                            withAnimation(Animation
                                .timingCurve(0.2, 0.2, 0.2, 0.2)
                                .speed(0.1)
                                .delay(1)
                                .repeatForever(autoreverses: false)
                            )
                            {
                                isAnimated.toggle()
                            }
                        }
                }
                
                //Prints the first and second element if its clicked 3 time
                else if DataModel.myShared.countEvents() == 3 {
                    Text(emoji[0] + emoji[1] + emoji[2]).offset(y: isAnimated ? 500 : -500)
                        .font(isAnimated ? .title3 : .title)
                        .onAppear {
                            withAnimation(Animation
                                .timingCurve(0.2, 0.2, 0.2, 0.2)
                                .speed(0.1)
                                .delay(1)
                                .repeatForever(autoreverses: false)
                            )
                            {
                                isAnimated.toggle()
                            }
                        }
                }
                
                //Prints the first and second element if its clicked 3 time
                else if DataModel.myShared.countEvents() == 4 {
                    Text(emoji[0] + emoji[1] + emoji[2] + emoji[3]).offset(y: isAnimated ? 500 : -500)
                        .font(isAnimated ? .title3 : .title)
                        .onAppear {
                            withAnimation(Animation
                                .timingCurve(0.2, 0.2, 0.2, 0.2)
                                .speed(0.1)
                                .delay(1)
                                .repeatForever(autoreverses: false)
                            )
                            {
                                isAnimated.toggle()
                            }
                        }
                }
                
                //Prints the whole emoji array if it is clicked 5 or more times
                else {
                    HStack {
                        ForEach(emoji, id: \.self) { emojis in
                            Text(emojis).offset(y: isAnimated ? 500 : -500)
                                .font(isAnimated ? .title3 : .title)
                                .onAppear {
                                    withAnimation(Animation
                                        .timingCurve(0.2, 0.2, 0.2, 0.2)
                                        .speed(0.1)
                                        .delay(1)
                                        .repeatForever(autoreverses: false)
                                    )
                                    {
                                        isAnimated.toggle()
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
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
        
        return DetailView(fruit: fruit)
    }
}
