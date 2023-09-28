//
//  Onboarding.swift
//  FoodOrder
//
//  Created by Shreya Prasad on 28/09/23.
//

import SwiftUI
let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email"
let kIsLoggedIn = "kIsLoggedIn"
struct Onboarding: View {
    @State  var firstName: String = ""
    @State  var lastName: String = ""
    @State  var email: String = ""
    @State  var isLogin: Bool = false

    var body: some View {
        NavigationView {
            VStack(
                spacing: 10
            ){
                
                NavigationLink(isActive: $isLogin) {

                            Home()

                          } label: {

                            EmptyView()

                          }
                Image("logo")
                TextField("First Name", text: $firstName )
                    .padding()

                TextField("Last Name", text: $lastName)
                      .padding()

                TextField("Email", text: $email)
                    .padding()

                Button("Sign In", action: {
                    if firstName.isEmpty{}
                    else if lastName.isEmpty{}
                    else if email.isEmpty{}
                    else{
                        print("login")

                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        isLogin = true

                        
                    }
            
                    
                })

        }.textFieldStyle(.roundedBorder).buttonStyle(.bordered)
                .onAppear{
                    if UserDefaults.standard.bool(forKey:kIsLoggedIn){
                        isLogin = true
                    }
                }
                
        }

    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}

