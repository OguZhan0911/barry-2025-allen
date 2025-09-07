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
                    Text(NSLocalizedString("tab_home", comment: "Home tab title"))
                }
            NewsView()
                .tabItem {
                    Image(systemName: "newspaper")
                    Text(NSLocalizedString("tab_news", comment: "News tab title"))
                }
            ToolsView()
                .tabItem {
                    Image(systemName: "wrench.and.screwdriver")
                    Text(NSLocalizedString("tab_tools", comment: "Tools tab title"))
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text(NSLocalizedString("tab_profile", comment: "Profile tab title"))
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
