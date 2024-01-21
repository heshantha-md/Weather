//
//  WeatherView.swift
//  Weather
//
//  Created by Heshantha Don on 20/01/2024.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        ZStack {
            // MARK: - Background Color
            Color.background
                .ignoresSafeArea()
            
            // MARK: - Weather Widgets
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(Forecast.cities) { forecast in
                        WeatherWidget(forecast: forecast)
                    }
                }
            }
            .safeAreaInset(edge: .top) {
                EmptyView()
                    .frame(height: 110)
            }
        }
        .overlay {
            // MARK: - Navigation Bar
            NavigationBar()
        }
        .toolbar(.hidden)
    }
}

#Preview {
    WeatherView()
        .preferredColorScheme(.dark)
}
