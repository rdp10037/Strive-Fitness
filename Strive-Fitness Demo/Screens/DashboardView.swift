//
//  DashboardView.swift
//  Strive-Fitness Demo
//
//  Created by Rob Pee on 4/26/24.
//

import SwiftUI
import Charts

enum HealthMetricContext: CaseIterable, Identifiable {
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
    @State private var selectedStat: HealthMetricContext = .steps

    var isSteps: Bool { selectedStat == .steps }

    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 20){
                    
                    Picker("Selected Stat", selection: $selectedStat) {
                        ForEach(HealthMetricContext.allCases) { metric in
                            Text(metric.title)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    // Chart section
                    VStack {
                        StepBarChart(selectedStart: selectedStat, chartData: hkManager.stepData)
                    }
                    
                    
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
  //                           await hkManager.addSimulatorData()
                await hkManager.fetchStepCount()
                ChartMath.averageWeekdayCount(for: hkManager.stepData)
                isShowingPermissionPrimingSheet = !hasSeenPermisionPriming
            }
            .navigationTitle("Dashboard")
            .navigationDestination(for: HealthMetricContext.self) { metric in
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
