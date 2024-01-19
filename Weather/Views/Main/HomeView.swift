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
    @State var bottomSheetSelectedDetent: BottomSheet.PresentationDetent = .medium
    @State var bottomSheetTranslation: CGFloat = BottomSheet.PresentationDetent.medium.size
    
    var bottomSheetTranslationProrated: CGFloat {
        withAnimation {
             let translationProrated = (bottomSheetTranslation - BottomSheet.PresentationDetent.medium.size) / BottomSheet.PresentationDetent.medium.size
             return translationProrated > 0.79 ? 1 : translationProrated < 0 ? 0 : translationProrated
        }
    }
    
    @State var hasDragged = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                let imageOffSet = screenHeight + 36
                
                ZStack {
                    // MARK: - Background Color
                    Color.background
                        .ignoresSafeArea()
                    
                    // MARK: - Background Image
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea()
                        .offset(y: -bottomSheetTranslationProrated * imageOffSet)
//                        .opacity(1 - bottomSheetTranslationProrated)
                    
                    // MARK: - House Image
                    Image("House")
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, 257)
                        .offset(y: -bottomSheetTranslationProrated * imageOffSet)
//                        .opacity(1 - bottomSheetTranslationProrated)
                    
                    VStack(spacing: -10 * (1 - bottomSheetTranslationProrated)) {
                        Text("Montreal")
                            .font(.largeTitle)
                        
                        VStack {
                            Text(attributedString)
                            
                            // MARK: - Current Weather
                            Text("H:24°   L:18°")
                                .font(.title3.weight(.semibold))
                                .opacity(1 - bottomSheetTranslationProrated)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 40)
                    .offset(y: -bottomSheetTranslationProrated * 33)
                    
                    // MARK: - Bottom Sheet
                    .sheetPlus(isPresented: $isPresented,
                               background: Blur(radius: 25, opaque: true)
                                            .background(Color.bottomSheetBackground)
                                            .clipShape(RoundedRectangle(cornerRadius: 44))
                                            .innerShadow(shape: RoundedRectangle(cornerRadius: 44),
                                                         color: Color.bottomSheetBorderMiddle,
                                                         lineWidth: 1,
                                                         offsetX: 0,
                                                         offsetY: 1,
                                                         blur: 0,
                                                         blendMode: .overlay,
                                                         opacity: 1 - bottomSheetTranslationProrated)
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
                                   bottomSheetTranslation = translation
                                   withAnimation(.easeInOut) {
                                       hasDragged = bottomSheetSelectedDetent == .large
                                   }
                               },
                               header: { EmptyView() },
                               main: {
                                    ForecastView()
                                        .presentationDetentsPlus(
                                            [.medium, .large],
                                            selection: $bottomSheetSelectedDetent
                                        )
                                        .presentationBackgroundInteractionPlus(.enabled(upThrough: .height(580)))
                               })
                    
                    // MARK: - Tab Bar
                    TabBar(action: {
                        bottomSheetSelectedDetent = .large
                    })
                    .offset(y: bottomSheetTranslationProrated * 115)
                    .opacity(1 - bottomSheetTranslationProrated)
                }
            }
        }
    }
    
    private var attributedString: AttributedString {
        var string = AttributedString("19°" + (hasDragged ? " | " : "\n ") + "Mostly Clear")
        if let temp = string.range(of: "19°") {
            string[temp].font = .system(size: 96 - (bottomSheetTranslationProrated * (96 - 20)), weight: hasDragged ? .semibold : .thin)
            string[temp].foregroundColor = hasDragged ? .secondary : .primary
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
