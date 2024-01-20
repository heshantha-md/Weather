//
//  ForecastCard.swift
//  Weather
//
//  Created by Heshantha Don on 20/01/2024.
//

import SwiftUI

struct ForecastCard: View {
    // MARK: - PROPERTIES
    var forecast: Forecast
    var forecastPeriod: ForecastPeriod
    var isActive: Bool {
        forecastPeriod == ForecastPeriod.hourly ? Calendar.current.isDate(.now, equalTo: forecast.date, toGranularity: .hour) : Calendar.current.isDate(.now, equalTo: forecast.date, toGranularity: .day)
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                Text(forecast.date, format: forecastPeriod == ForecastPeriod.hourly ? .dateTime.hour() : .dateTime.weekday())
                    .font(.subheadline.weight(.semibold))
                
                VStack(spacing: -4) {
                    // MARK: - Forecast Small Icon
                    Image("\(forecast.icon) small")
                    
                    // MARK: - Forecast Probability
                    Text(forecast.probability, format: .percent)
                        .font(.footnote.weight(.semibold))
                        .foregroundStyle(Color.probabilityTextColor)
                        .opacity(forecast.probability > 0 ? 1 : 0)
                }
                .frame(height: 42)
                
                // MARK: - Forecast Temperature
                Text("\(forecast.temperature)°")
                    .font(.title3)
            }
            .frame(width: 60, height: 146)
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
        }
        .background {
            // MARK: - Card
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.forecastCardBackground.opacity(isActive ? 1 : 0.2))
                .frame(width: 60, height: 146)
                .shadow(color: .black.opacity(0.25), radius: 10, x: 5, y: 4)
                .overlay {
                    // MARK: - Card Border
                    RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(.white.opacity(isActive ? 0.5 : 0.2))
                        .blendMode(.overlay)
                }
                .innerShadow(shape: RoundedRectangle(cornerRadius: 30),
                             color: .white.opacity(0.25),
                             lineWidth: 1,
                             offsetX: 1,
                             offsetY: 1,
                             blur: 0,
                             blendMode: .overlay)
        }
    }
}

#Preview {
    ForecastCard(forecast: Forecast.hourly[0],
                 forecastPeriod: .hourly)
            .preferredColorScheme(.dark)
}
