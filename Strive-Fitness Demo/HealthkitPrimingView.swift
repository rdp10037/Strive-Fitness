//
//  HealthkitPrimingView.swift
//  Strive-Fitness Demo
//
//  Created by Rob Pee on 4/27/24.
//

import SwiftUI
import HealthKitUI

struct HealthkitPrimingView: View {
    
    @Environment(HealthKitManager.self) private var hkManager
    @Environment (\.dismiss) private var dismiss
    @State private var isShowingHealthKitPermissions: Bool = false
    
    var description = """
This app displays your step and weight data in interactive charts.

You can also add new step or weight data to apple health from this app. Your data is private and secured.
"""
    
    var body: some View {
        VStack {
            Spacer()
            VStack (alignment: .leading){
                
                Image(.healthKitSmall)
                    .resizable()
                    .frame(width: 90, height: 90)
                    .shadow(color: .gray.opacity(0.3), radius: 16)
                    .padding(.bottom, 12)
                Text("Apple Health Integration")
                    .font(.title2.bold())
                    .padding(.bottom, 8)
                Text(description)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            
            Button {
                isShowingHealthKitPermissions = true
            } label: {
                Text("Connect Apple Health")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 18)
                    .background(Color.pink)
                    .clipShape(Capsule())
            }

            Spacer()
        }
        .padding(30)
        .healthDataAccessRequest(store: hkManager.store,
                                 shareTypes: hkManager.types,
                                 readTypes: hkManager.types,
                                 trigger: isShowingHealthKitPermissions) { result in
            switch result {
            case .success(_):
               dismiss()
            case .failure(_):
                dismiss()
            }
        }
    }
}

#Preview {
    HealthkitPrimingView()
        .environment(HealthKitManager())
}
