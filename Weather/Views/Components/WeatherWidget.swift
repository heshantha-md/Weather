//
//  WeatherWidget.swift
//  Weather
//
//  Created by Heshantha Don on 21/01/2024.
//

import SwiftUI

struct WeatherWidget: View {
    // MARK: - PROPERTIES
    var forecast: Forecast
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // MARK: - Trapezoid
            Trapezoid()
                .fill(Color.weatherWidgetBackground)
                .frame(width: 342, height: 174)
            
            // MARK: - Content
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 8) {
                    // MARK: - Forecast Temperature
                    Text("\(forecast.temperature)°")
                        .font(.system(size: 64))
                    
                    VStack(alignment: .leading, spacing: 2) {
                        // MARK: - Forecast Temperature Range
                        Text("H:\(forecast.high)°  L:\(forecast.low)°")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        
                        // MARK: - Forecast Location
                        Text(forecast.location)
                            .font(.body)
                            .lineLimit(1)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 0) {
                    // MARK: - Forecast Large Image
                    Image("\(forecast.icon) large")
                        .padding(.trailing, 4)
                    
                    // MARK: - Weather
                    Text(forecast.weather.rawValue)
                        .font(.footnote)
                        .padding(.trailing, 24)
                }
            }
            .padding(.bottom, 20)
            .padding(.leading, 20)
        }
        .frame(width: 342, height: 184, alignment: .bottom)
    }
}

#Preview {
    WeatherWidget(forecast: Forecast.weekly[0])
        .preferredColorScheme(.dark)
}
