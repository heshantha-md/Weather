//
//  WeatherView.swift
//  Weather
//
//  Created by Heshantha Don on 20/01/2024.
//

import SwiftUI

struct WeatherView: View {
    @State private var searchText = ""
    var searchResult: [Forecast] {
        searchText.isEmpty ? Forecast.cities : Forecast.cities.filter { $0.location.contains(searchText) }
    }
    
    var body: some View {
        ZStack {
            // MARK: - Background Color
            Color.background
                .ignoresSafeArea()
            
            // MARK: - Weather Widgets
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(searchResult) { forecast in
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
            NavigationBar(searchText: $searchText)
        }
        .toolbar(.hidden)
//        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for a city or airport")
    }
}

#Preview {
    NavigationStack {
        WeatherView()
            .preferredColorScheme(.dark)
    }
}
