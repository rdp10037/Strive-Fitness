//
//  AddDataSheet.swift
//  Strive-Fitness Demo
//
//  Created by Rob Pee on 4/27/24.
//

import SwiftUI

struct AddDataSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var addDataDate: Date = .now
    @State private var valueToAdd: String = ""
    var metricTitle: String
    var metricType: HealthMetricContext
        
    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Date", selection: $addDataDate, displayedComponents: .date)
                HStack {
                    Text(metricTitle)
                    Spacer()
                    TextField("Value", text: $valueToAdd)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 150)
                        .keyboardType(metricType == .steps ? .numberPad : .decimalPad)
                }
            }
            .navigationTitle(metricTitle)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Dismiss") {
                      dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Data") {
                       // do code later
                    }
                }
            }
        }
    }
}

#Preview {
    AddDataSheet(metricTitle: "Test", metricType: .steps)
}
