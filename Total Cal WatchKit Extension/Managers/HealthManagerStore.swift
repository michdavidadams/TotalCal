//
//  HealthManagerStore.swift
//  Total Cal WatchKit Extension
//
//  Created by Michael Adams on 11/16/21.
//

import HealthKit

class HealthStore {
    
    // Provides features for acessing and writing data
    var healthStore: HKHealthStore?
    
    var hkquery: HKStatisticsCollectionQuery?
    
    init() {
        // Checks if HealthKit is available on this device
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        
        // Types of data we're requesting from HealthKit
        // Calories consumed
        let dietaryEnergy = HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!
        // Calories burned
        let activeEnergy = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        // Resting calories burned
        let restingEnergy = HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned)!
        
        let hkTypesToRead: Set<HKObjectType> = [dietaryEnergy, activeEnergy, restingEnergy]
        let hkTypesToWrite: Set<HKSampleType> = []
        
        guard let healthStore = healthStore else { return completion(false) }
        
        healthStore.requestAuthorization(toShare: hkTypesToWrite, read: hkTypesToRead) { (success, error) in
            completion(success)
        }

    }
    
    // Calculate energy consumed
    func calculateDietaryEnergy(completion: @escaping (HKStatisticsCollection?) -> Void) {
        let dietaryEnergy = HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!
        
        // Midnight
        let midnight = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        
        // Anchor date/time
        let anchorDate = Date.now
        
        // Calculated daily
        let daily = DateComponents(day: 1)
       
        // Access data from midnight to current date
        let predicate = HKQuery.predicateForSamples(withStart: midnight, end: Date(), options: .strictStartDate)
        
        hkquery = HKStatisticsCollectionQuery(quantityType: dietaryEnergy, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
        
        hkquery!.initialResultsHandler = { query, statisticsCollection, error in
            completion(statisticsCollection)
        }
        
        if let healthStore = healthStore, let query = hkquery {
            healthStore.execute(query)
        }
    }
    
    // Calculate active energy burned
    func calculateActiveEnergy(completion: @escaping (HKStatisticsCollection?) -> Void) {
        let activeEnergy = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        
        // Midnight
        let midnight = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        
        // Anchor date/time
        let anchorDate = Date.now
        
        // Calculated daily
        let daily = DateComponents(day: 1)
       
        // Access data from midnight to current date
        let predicate = HKQuery.predicateForSamples(withStart: midnight, end: Date(), options: .strictStartDate)
        
        hkquery = HKStatisticsCollectionQuery(quantityType: activeEnergy, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
        
        hkquery!.initialResultsHandler = { query, statisticsCollection, error in
            completion(statisticsCollection)
        }
        
        if let healthStore = healthStore, let query = hkquery {
            healthStore.execute(query)
        }
    }
    
    // Calculate resting energy burned
    func calculateRestingEnergy(completion: @escaping (HKStatisticsCollection?) -> Void) {
        let restingEnergy = HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned)!
        
        // Midnight
        let midnight = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        
        // Anchor date/time
        let anchorDate = Date.now
        
        // Calculated daily
        let daily = DateComponents(day: 1)
       
        // Access data from midnight to current date
        let predicate = HKQuery.predicateForSamples(withStart: midnight, end: Date(), options: .strictStartDate)
        
        hkquery = HKStatisticsCollectionQuery(quantityType: restingEnergy, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
        
        hkquery!.initialResultsHandler = { query, statisticsCollection, error in
            completion(statisticsCollection)
        }
        
        if let healthStore = healthStore, let query = hkquery {
            healthStore.execute(query)
        }
    }
    
}
