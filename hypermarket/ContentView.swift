//
//  ContentView.swift
//  hypermarket
//
//  Created by Barry Allen on 13/7/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            NewsView()
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("News")
                }
            ToolsView()
                .tabItem {
                    Image(systemName: "wrench.and.screwdriver")
                    Text("Tools")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
