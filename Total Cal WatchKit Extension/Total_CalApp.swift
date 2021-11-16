//
//  Total_CalApp.swift
//  Total Cal WatchKit Extension
//
//  Created by Michael Adams on 10/3/21.
//

import SwiftUI
import HealthKit

@main
struct Total_CalApp: App {
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
