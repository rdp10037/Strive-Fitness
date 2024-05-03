//
//  ChartDataTypes.swift
//  Strive-Fitness Demo
//
//  Created by Rob Pee on 5/1/24.
//

import Foundation

struct WeekdayChartData: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}
