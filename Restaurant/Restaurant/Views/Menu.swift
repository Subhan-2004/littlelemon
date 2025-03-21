//
//  Menu.swift
//  Restaurant
//
//  Created by APPLE on 3/17/25.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var searchText: String = ""


    var body: some View {
        VStack {
            Text("Menu")
                .font(.largeTitle)
            
            TextField("Search menu", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Fetch Objects from Core Data
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes, id: \.self) { dish in
                        HStack {
                            Text("\(dish.title!) - $\(dish.price!)")
                            
                            AsyncImage(url: URL(string: dish.image!)) { image in
                                image
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            getMenuData()
        }
    }

    func getMenuData() {
        // 1. Define the API URL
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        guard let url = URL(string: urlString) else { return }

        // 2. Create URL request
        let request = URLRequest(url: url)

        // 3. Fetch data
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }

            // 4. Decode JSON data
            if let decodedResponse = try? JSONDecoder().decode(MenuList.self, from: data) {
                DispatchQueue.main.async {
                    saveToCoreData(menuItems: decodedResponse.menu)
                }
            }
        }

        task.resume()
    }

    // 5. Save Data to Core Data
    func saveToCoreData(menuItems: [MenuItem]) {
        let persistence = PersistenceController.shared
        let viewContext = persistence.container.viewContext // Ensure correct context

        persistence.clear() // Clear previous data before saving

        for item in menuItems {
            let dish = Dish(context: viewContext) // Create new Dish object
            dish.title = item.title
            dish.image = item.image
            dish.price = item.price
        }

        do {
            try viewContext.save() // Save data
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true) // No filtering
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }


}

#Preview {
    Menu()
}
