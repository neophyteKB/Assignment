//
//  LoadingSpinner.swift
//  Blessings
//
//  Created by Kamal Kishor on 28/11/24.
//

import SwiftUI

struct LoadingSpinner: ViewModifier {
    @Binding var isLoading: Bool
    func body(content: Content) -> some View {
        if isLoading {
            content.overlay {
                loaderView
            }
        } else {
            content
        }
    }
    
    private var loaderView: some View {
        ZStack {
            Color.black.opacity(0.2)
                .edgesIgnoringSafeArea(.all)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(1.5)
        }
    }
}

extension View {
    func showLoader(_ isLoading: Binding<Bool>) -> some View {
        self.modifier(LoadingSpinner(isLoading: isLoading))
    }
}
