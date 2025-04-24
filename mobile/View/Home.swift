//
//  Home.swift
//  Desafio10
//
//  Created by Turma01-18 on 31/03/25.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack{
            TabView{
                Group{
                    ContentView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                    Profile()
                        .tabItem {
                            Image(systemName: "person.crop.circle.fill")
                            Text("Profile")
                        }
                }
            }
        }
    }
}
    
    #Preview {
        Home()
    }
