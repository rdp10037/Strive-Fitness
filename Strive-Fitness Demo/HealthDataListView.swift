//
//  HealthDataListView.swift
//  Strive-Fitness Demo
//
//  Created by Rob Pee on 4/27/24.
//

import SwiftUI

struct HealthDataListView: View {
    @State private var isShowingData = false
    var metric: HealthMetricContent
    
    var body: some View {
        List(0..<28) { i in
            HStack {
                Text(Date(), format: .dateTime.month().day().year())
                Spacer()
                Text(10000, format: .number.precision(.fractionLength(metric == .steps ? 0 : 1)))
            }
        }
        .navigationTitle(metric.title)
        .sheet(isPresented: $isShowingData) {
            AddDataSheet(metricTitle: metric.title, metricType: metric)
        }
        .toolbar {
            Button("Add Data", systemImage: "plus") {
                isShowingData = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        HealthDataListView(metric: .steps)
    }
}
