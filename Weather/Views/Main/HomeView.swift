//
//  HomeView.swift
//  Weather
//
//  Created by Heshantha Don on 18/01/2024.
//

import SwiftUI
import BottomSheet

struct HomeView: View {
    // MARK: - PROPERTIES
    @State var isPresented = true
    @State var selectedDetent: BottomSheet.PresentationDetent = .medium
    
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: - Background Color
                Color.background
                    .ignoresSafeArea()
                
                // MARK: - Background Image
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
                
                // MARK: - House Image
                Image("House")
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.top, 257)
                
                VStack {
                    Text("Montreal")
                        .font(.largeTitle)
                    
                    VStack {
                        Text(attributedString)
                        
                        Text("H:24°   L:18°")
                            .font(.title3.weight(.semibold))
                    }
                    
                    Spacer()
                }
                .padding(.top, 51)
                
                // MARK: - Bottom Sheet
                .sheetPlus(isPresented: $isPresented,
                           background: Blur(radius: 25, opaque: true)
                                        .background(Color.bottomSheetBackground)
                                        .clipShape(RoundedRectangle(cornerRadius: 44))
                                        .overlay {
                                            // MARK: - Bottom Sheet Separator
                                            Divider()
                                                .blendMode(.overlay)
                                                .background(Color.bottomSheetBorderTop)
                                                .frame(maxHeight: .infinity, alignment: .top)
                                                .clipShape(RoundedRectangle(cornerRadius: 44))
                                        }
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(.black.opacity(0.5))
                                                .frame(width: 48, height: 5)
                                                .frame(height: 20)
                                                .frame(maxHeight: .infinity, alignment: .top)},
                           onDrag: { translation in
                               print(translation)
                           },
                           header: { EmptyView() },
                           main: {
                                ForecastView()
                                    .presentationDetentsPlus(
                                        [.height(770), .fraction(0.4), .medium, .large],
                                        selection: $selectedDetent
                                    )
                                    .presentationBackgroundInteractionPlus(.enabled(upThrough: .height(325)))
                           })
                
                // MARK: - Tab Bar
                TabBar(action: {
                    selectedDetent = .large
                })
            }
        }
    }
    
    private var attributedString: AttributedString {
        var string = AttributedString("19°" + "\n " + "Mostly Clear")
        if let temp = string.range(of: "19°") {
            string[temp].font = .system(size: 96, weight: .thin)
            string[temp].foregroundColor = .primary
        }
        
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary
        }
        
        if let weather = string.range(of: "Mostly Clear") {
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        return string
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
