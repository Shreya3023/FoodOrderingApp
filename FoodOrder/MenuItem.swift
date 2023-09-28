//
//  MenuItem.swift
//  FoodOrder
//
//  Created by Shreya Prasad on 28/09/23.
//

import SwiftUI

//Conform to Decodable Protocol
struct MenuItem: Decodable {
    
    //Declare Item Properties
    let title : String
    let price : String
    let image: String
}
