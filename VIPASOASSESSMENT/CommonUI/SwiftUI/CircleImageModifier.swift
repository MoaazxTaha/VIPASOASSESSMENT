//
//  CircleImageModifier.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 22/05/2024.
//

import SwiftUI

struct CircleImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .shadow(radius: 5)
            .padding()
    }
}

// Create an extension for easy usage
extension View {
    func circleImageStyle() -> some View {
        self.modifier(CircleImageModifier())
    }
}
