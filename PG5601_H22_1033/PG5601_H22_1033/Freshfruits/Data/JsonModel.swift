import Foundation

//url to fruit
let url = "https://fruityvice.com/api/fruit/all"

// STRUCT identical with JSON data
struct JsFruit: Identifiable, Decodable {
    let id: Int
    let name: String
    let family: String
    let genus: String
    let order: String
    let nutritions: JsNutritions
}

struct JsNutritions: Decodable {
    let carbohydrates: Double
    let calories: Double
    let protein: Double
    let sugar: Double
    let fat: Double
}

// JSON class observable
final class JsonModel: ObservableObject {
    @Published var fruits: [JsFruit] = []
    
    // Download data from url
    func loadFruits() async {
        // Oppretter en HTTP kobling
        guard let myurl = URL(string: url) else {
            print("Beklager, ingen respons fra serveren:\n\n\(url)")
            return
        }
        
        do {
            // Transfer data through HTTP
            let (data, _) = try await URLSession.shared.data(from: myurl)
            
            // Decodes data downloaded
            fruits = try JSONDecoder().decode([JsFruit].self, from: data)
        }
        catch {
            print("Beklager, kan ikke dekode innholdet fra\n\n\(url)")
        }
    }
}
