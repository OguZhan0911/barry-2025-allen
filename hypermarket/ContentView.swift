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
            ArticlesView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Articles")
                }
            ToolsView()
                .tabItem {
                    Image(systemName: "wrench")
                    Text("Tools")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
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
