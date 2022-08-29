//
//  crypto_watchApp.swift
//  crypto-watch WatchKit Extension
//
//  Created by Jonatan Scaglia on 29/08/2022.
//

import SwiftUI

@main
struct crypto_watchApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
