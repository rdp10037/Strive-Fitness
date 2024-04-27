//
//  HealthKitManager.swift
//  Strive-Fitness Demo
//
//  Created by Rob Pee on 4/27/24.
//

import Foundation
import HealthKit
import Observation

@Observable class HealthKitManager {
    
    let store = HKHealthStore()
    
    let types: Set = [HKQuantityType(.stepCount), HKQuantityType(.bodyMass)]
}
