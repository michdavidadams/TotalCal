//
//  ContentView.swift
//  Total Cal WatchKit Extension
//
//  Created by Michael Adams on 10/3/21.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @ObservedObject var caloriesViewModel = CaloriesViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Energy Consumed, fatass.".uppercased())
                    .font(.system(size: 13))
                    .bold()
                //Text("\(caloriesViewModel)")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
