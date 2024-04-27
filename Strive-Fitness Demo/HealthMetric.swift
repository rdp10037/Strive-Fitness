//
//  HealthMetric.swift
//  Strive-Fitness Demo
//
//  Created by Rob Pee on 4/27/24.
//

import Foundation

struct HealthMetric: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}
