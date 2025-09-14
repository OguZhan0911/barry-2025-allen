//
//  hypermarketApp.swift
//  hypermarket
//
//  Created by Barry Allen on 13/7/2025.
//

import SwiftUI
import UIKit

@main
struct hypermarketApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("followSystem") private var followSystem = true
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(
                   // 传 nil，App 就会根据 iOS/macOS 的系统设置自动切换暗/亮色。
                   // 传 .dark 或 .light，App 就会忽略系统设置，始终用指定的模式。
                    isDarkMode ? (followSystem ? nil : .dark) : .light
                )
        }
    }
}
