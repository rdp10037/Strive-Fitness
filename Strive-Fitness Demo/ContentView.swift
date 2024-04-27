//
//  ContentView.swift
//  Strive-Fitness Demo
//
//  Created by Rob Pee on 4/26/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 20){
                    // Card section
                    VStack {
                        HStack {
                            VStack (alignment: .leading){
                                Label("Steps", systemImage: "figure.walk")
                                    .font(.title3.bold())
                                    .foregroundStyle(.pink)
                                Text("Avg 10K steps")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                        }
                        .padding(.bottom)
                        
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.secondary)
                            .frame(height: 150)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(.ultraThinMaterial))
                    
                    
                    // Card section
                    VStack (alignment: .leading){
                        VStack (alignment: .leading){
                            Label("Averages", systemImage: "calendar")
                                .font(.title3.bold())
                                .foregroundStyle(.orange)
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
            .navigationTitle("Dashboard")
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    ContentView()
}
