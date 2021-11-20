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

class HealthKitHealthStore: ObservableObject {
    var healthStore: HKHealthStore?
    init() {
            if HKHealthStore.isHealthDataAvailable() {
                healthStore = HKHealthStore()
            }
        }
    func setUpHealthStore() {
            let typesToRead: Set = [
                HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!,
                HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
                HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned)!
            ]
            healthStore?.requestAuthorization(toShare: nil, read: typesToRead, completion: { success, error in
                if success {
                    print("--> requestAuthorization")
                    self.calculateDietaryEnergy()
                }
            })
        }
    
    // Read data
    @Published var dietaryEnergyValue: HKQuantity?
    @Published var activeEnergyValue: HKQuantity?
    @Published var restingEnergyValue: HKQuantity?
    var query: HKStatisticsQuery!

    func calculateDietaryEnergy() {
            guard let dietaryEnergy = HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed) else {
                // This should never fail when using a defined constant.
                fatalError("*** Unable to get the bloodPressure count ***")
            }
            query = HKStatisticsQuery(quantityType: dietaryEnergy,
                                      quantitySamplePredicate: nil,
                                      options: .cumulativeSum) {
                query, statistics, error in
                DispatchQueue.main.async{
                    self.dietaryEnergyValue = HKQuantity(unit: HKUnit(from: .kilocalorie), doubleValue: 0000)
                    print("----> calculateDietaryEnergy statistics: \(statistics)")
                    print("----> calculateDietaryEnergy error: \(error)")
                    print("----> calculateDietaryEnergy: \(self.dietaryEnergyValue)")
                }
            }
            healthStore!.execute(query!)
        }

}
