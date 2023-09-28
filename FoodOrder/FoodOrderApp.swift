//
//  FoodOrderApp.swift
//  FoodOrder
//
//  Created by Shreya Prasad on 28/09/23.
//

import SwiftUI

@main
struct RestaurantApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup{
            Onboarding()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
}
