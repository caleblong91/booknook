//
//  homePage.swift
//  booknook
//
//  Created by Caleb Long on 8/10/23.
//

import SwiftUI

struct homePage: View {
    @EnvironmentObject var viewModel : authViewModel
    var body: some View {
        TabView {
                    // First Tab
                    Text("First Tab Content")
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                    
                    // Second Tab
                    Text("Second Tab Content")
                        .tabItem {
                            Image(systemName: "heart.fill")
                            Text("Favorites")
                        }
                    
                    // Third Tab
                    Text("Third Tab Content")
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("Profile")
                        }
            
                    // Fourth Tab
                    profileView()
                        .tabItem{
                            Image(systemName: "person.fill")
                            Text("Profile")
                        }
                }
    }
}

struct homePage_Previews: PreviewProvider {
    static var previews: some View {
        homePage()
    }
}
