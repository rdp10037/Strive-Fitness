//
//  Strive_Fitness_DemoApp.swift
//  Strive-Fitness Demo
//
//  Created by Rob Pee on 4/26/24.
//

import SwiftUI

@main
struct Strive_Fitness_DemoApp: App {
    
    let hkManager = HealthKitManager()
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environment(hkManager)
        }
    }
}
