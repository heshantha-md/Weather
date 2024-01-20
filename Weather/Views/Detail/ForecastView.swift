//
//  ForecastView.swift
//  Weather
//
//  Created by Heshantha Don on 19/01/2024.
//

import SwiftUI

struct ForecastView: View {
    // MARK: - PROPERTIES
    var bottomSheetTranslationProrated: CGFloat = 1
    @State private var selection = 0
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Segmented Control
            SegmentedControl(selection: $selection)
            
            // MARK: - Forecast Cards
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    if selection == 0 {
                        ForEach(Forecast.hourly) { forecast in
                            ForecastCard(forecast: forecast, forecastPeriod: .hourly)
                        }
                        .transition(.offset(x: -430))
                    } else {
                        ForEach(Forecast.weekly) { forecast in
                            ForecastCard(forecast: forecast, forecastPeriod: .weekly)
                        }
                        .transition(.offset(x: 430))
                    }
                }
                .padding(.vertical, 10)
            }
            .padding(.horizontal, 20)
            
            // MARK: - Forecast Widgets
            Image("Forecast Widgets")
                .opacity(bottomSheetTranslationProrated)
        }
    }
}

#Preview {
    ForecastView()
        .background(Color.background)
        .preferredColorScheme(.dark)

}
