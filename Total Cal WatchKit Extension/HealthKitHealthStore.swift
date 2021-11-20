//
//  HealthKitHealthStore.swift
//  Total Cal WatchKit Extension
//
//  Created by Michael Adams on 11/19/21.
//

import HealthKit

class HealthKitHealthStore: ObservableObject {
    let healthStore = HKHealthStore()
    
    
    // Request authorization to access HealthKit.
    func requestAuthorization() {
        
        // The quantity types to read from the health store.
        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned)!
        ]
        
        // Request authorization for those quantity types.
        healthStore.requestAuthorization(toShare: [], read: typesToRead) { (success, error) in
            // Handle error.
        }
    }
    
    // Read data
    @Published var dietaryEnergy: Double = 0
    @Published var activeEnergy: Double = 0
    @Published var restingEnergy: Double = 0
    var query: HKStatisticsQuery!

    func calculateDietaryEnergy() {
            guard let dietaryEnergyValue = HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed) else {
                // This should never fail when using a defined constant.
                fatalError("*** Unable to get the bloodPressure count ***")
            }
            query = HKStatisticsQuery(quantityType: dietaryEnergyValue,
                                      quantitySamplePredicate: nil,
                                      options: .discreteAverage) {
                query, statistics, error in
                DispatchQueue.main.async{
                    print("----> calculateBloodPressureSystolic statistics: \(statistics)")
                    print("----> calculateBloodPressureSystolic error: \(error)")
                    print("----> calculateBloodPressureSystolic: \(self.dietaryEnergy)")
                }
            }
            healthStore.execute(query)
        }

}
