//
//  ContentView.swift
//  Total Cal WatchKit Extension
//
//  Created by Michael Adams on 10/3/21.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @ObservedObject var healthStore = HealthKitHealthStore()
    var energyStandard = HKQuantity(unit: .kilocalorie(), doubleValue: 0000.0)
    
    var body: some View {
        VStack {
            Text("Dietary: \(healthStore.dietaryEnergy)")
        }.onAppear {
            healthStore.requestAuthorization()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
