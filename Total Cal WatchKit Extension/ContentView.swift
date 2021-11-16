//
//  ContentView.swift
//  Total Cal WatchKit Extension
//
//  Created by Michael Adams on 10/3/21.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    private var healthStore: HealthStore?
    @State private var calories: [Calorie] = []
    
    init() {
        healthStore = HealthStore()
    }
    var body: some View {
        Text("Test")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private func initialization() {
    if let healthStore = HealthStore {
        healthStore.requestAuthorization { success in
            if success {
                healthStore.calculateDietaryEnergy { statisticsCollection in
                    if let statisticsCollection = statisticsCollection {
                        updateFromStatistics(statisticsCollection)
                    }
                }
            }
        }
    }
}

private func updateFromStatistics( _ statisticsCollection: HKStatisticsCollection) {
        let startDate = Calendar.current.date(byAdding: .day, value: -30, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            
            let count  = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            steps.append(step)
        }
        // To Sort them elements from the latest
        steps.reverse()
        steps.removeFirst()
        
    }
}
