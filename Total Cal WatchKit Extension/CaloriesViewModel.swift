//
//  CaloriesViewModel.swift
//  Total Cal WatchKit Extension
//
//  Created by Michael Adams on 11/17/21.
//

import Foundation
import HealthKit

class CaloriesViewModel: ObservableObject {
    @Published var data: [HKCategorySample] = []
    let sumOption = HKStatisticsOptions.cumulativeSum
    
    init() {
        updateData()
    }
    
    func updateData() {
        
        if HKHealthStore.isHealthDataAvailable() {
            let healthStore = HKHealthStore()
           
            guard let consumedEnergy = HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed) else {
                fatalError("This method should never fail")
            }
            
            let observerQuery = HKObserverQuery(sampleType: consumedEnergy, predicate: nil) { query, completionHandler, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                let statisticsSumQuery = HKStatisticsQuery(quantityType: consumedEnergy, quantitySamplePredicate: nil, options: self.sumOption)
                      { (query, result, error) in
                          if let sumQuantity = result?.sumQuantity() {

                              let numberOfCalories = Int(sumQuantity.doubleValue(for: .kilocalorie()))
                              print(numberOfCalories)
                          }
                  }
                
                healthStore.execute(statisticsSumQuery)
                completionHandler()
            }
            
            healthStore.execute(observerQuery)
        } else {
            print("Healthkit not available")
        }
    }
}
