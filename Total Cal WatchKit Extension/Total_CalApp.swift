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
    
    init() {
        askHealthkitPermission()
    }
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }
        
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
    
    func askHealthkitPermission() {
        if HKHealthStore.isHealthDataAvailable() {
            let healthStore = HKHealthStore()
            
            let types = Set([
                HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!
            ])
            
            healthStore.requestAuthorization(toShare: types, read: types) { success, error in
                if !success {
                    fatalError("Something went wrong")
                }
            }
        } else {
            fatalError("Healthkit is not available")
        }
    }
}
