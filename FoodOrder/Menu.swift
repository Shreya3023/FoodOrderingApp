//
//  Menu.swift
//  FoodOrder
//
//  Created by Shreya Prasad on 28/09/23.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchParamters = ""
    var body: some View {
        VStack {
            Text("RESTAURANT")
            Text("Chicago")
            Text("App for order food from any place in Chicago")
            
            TextField( "Search menu",  text: $searchParamters)

            
         FetchedObjects(
            predicate: buildPredicate(),
            sortDescriptors: buildSortDescriptors()
         ) { (dishes: [Dish]) in
            List{
                ForEach(dishes, id: \.self) { dish in
                    HStack{
                        Text(dish.title ?? ""  )
                        
                        Text(dish.price ?? "")
                    }
                    AsyncImage(url: URL(string: dish.image ?? "")){ image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 200)
                   }
            }
        }
            
        }.onAppear{
            getMenuData()
        }
    }
    
    func getMenuData(){
    

        PersistenceController.shared.clear()
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let dataa = data {
                

                let fullMenu = try? JSONDecoder().decode(MenuList.self, from: dataa)
              

                let menuItems = fullMenu?.menu

                if let menuItems = menuItems{
                    for menuItem in menuItems {
                  
                        let oneDish = Dish(context: viewContext)
                        oneDish.title = menuItem.title
                        oneDish.price = menuItem.price
                        oneDish.image = menuItem.image
                        try? viewContext.save()

                    }
                }
            }
        }
        
        task.resume()
    }
    
    func buildSortDescriptors()->[NSSortDescriptor]{
        return[NSSortDescriptor(key:"title",
             ascending: true,
               selector:
              #selector(NSString.localizedStandardCompare)),]
    }
    func buildPredicate()-> NSPredicate {
        if(searchParamters.isEmpty){
            return NSPredicate(value: true)
            
        }
        else{
             
            return NSPredicate(format: "title CONTAINS[cd] %@", searchParamters)
        }
        
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}

