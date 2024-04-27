//
//  HealthkitPrimingView.swift
//  Strive-Fitness Demo
//
//  Created by Rob Pee on 4/27/24.
//

import SwiftUI

struct HealthkitPrimingView: View {
    
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
            
            Button("Connect Apple Health") {
                // TODO:
            }
            .buttonStyle(.borderedProminent)
            .tint(.pink)
            Spacer()
        }
        .padding(30)
    }
}

#Preview {
    HealthkitPrimingView()
}
