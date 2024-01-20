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
