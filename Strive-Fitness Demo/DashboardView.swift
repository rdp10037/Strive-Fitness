//
//  DashboardView.swift
//  Strive-Fitness Demo
//
//  Created by Rob Pee on 4/26/24.
//

import SwiftUI
import Charts

enum HealthMetricContent: CaseIterable, Identifiable {
    case steps, weight
    var id: Self { self }
    
    var title: String {
        switch self {
        case .steps:
            return "Steps"
        case .weight:
            return "Weight"
        }
    }
}

struct DashboardView: View {
    
    @Environment(HealthKitManager.self) private var hkManager
    @AppStorage("hasSeenPermisionPriming") private var hasSeenPermisionPriming = false
    @State private var isShowingPermissionPrimingSheet: Bool = false
    @State private var selectedStat: HealthMetricContent = .steps
    var isSteps: Bool { selectedStat == .steps }
    
    var avgStepCount: Double {
        guard !hkManager.stepData.isEmpty else { return 0}
        let totalSteps = hkManager.stepData.reduce(0) { $0 + $1.value }
        return totalSteps/Double(hkManager.stepData.count)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 20){
                    
                    Picker("Selected Stat", selection: $selectedStat) {
                        ForEach(HealthMetricContent.allCases) { metric in
                            Text(metric.title)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    // Card section
                    VStack {
                        NavigationLink(value: selectedStat){
                            HStack {
                                VStack (alignment: .leading){
                                    Label("Steps", systemImage: "figure.walk")
                                        .font(.title3.bold())
                                        .foregroundStyle(.pink)
                                    Text("Avg \(Int(avgStepCount)) steps")
                                        .font(.caption)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding(.bottom)
                        }
                        .foregroundStyle(.secondary)
                        
                  // charts
                        Chart {
                            RuleMark(y: .value("Average", avgStepCount))
                                .foregroundStyle(Color.secondary)
                                .lineStyle(.init(lineWidth: 1, dash: [5]))
                            ForEach(HealthMetric.mockData) { steps in
                       //     ForEach(hkManager.stepData) { steps in
                                BarMark(x: .value("Date", steps.date, unit: .day),
                                        y: .value("Steps", steps.value)
                                )
                                .foregroundStyle(Color.pink.gradient)
                            }
                        }
                        .frame(height: 150)
                        .chartXAxis {
                            AxisMarks {
                                AxisValueLabel(format: .dateTime.month(.defaultDigits).day())
                            }
                        }
                        .chartYAxis {
                            AxisMarks { value in
                                AxisGridLine()
                                    .foregroundStyle(Color.secondary.opacity(0.3))
                                
                                AxisValueLabel((value.as(Double.self) ?? 0).formatted(.number.notation(.compactName)))
                            }
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(.ultraThinMaterial))
                    
                    
                    // Card section
                    VStack (alignment: .leading){
                        VStack (alignment: .leading){
                            Label("Averages", systemImage: "calendar")
                                .font(.title3.bold())
                                .foregroundStyle(.pink)
                            Text("Last 28 Days")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.bottom, 12)
                        
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.secondary)
                            .frame(height: 240)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(.ultraThinMaterial))
                }
                .padding()
            }
            .task {
                //             await hkManager.fetchStepCount()
                await hkManager.fetchStepCount()
                isShowingPermissionPrimingSheet = !hasSeenPermisionPriming
            }
            .navigationTitle("Dashboard")
            .navigationDestination(for: HealthMetricContent.self) { metric in
                HealthDataListView(metric: metric)
            }
            .scrollIndicators(.hidden)
            .sheet(isPresented: $isShowingPermissionPrimingSheet) {
                // fetch health data
            } content: {
                HealthkitPrimingView(hasSeen: $hasSeenPermisionPriming)
            }
            
        }
        .tint(isSteps ? .pink : .indigo)
    }
}

#Preview {
    DashboardView()
        .environment(HealthKitManager())
}
