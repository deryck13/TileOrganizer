//
//  View+Additions.swift
//  TileOrganizer
//

import SwiftUI

extension View {
    @ViewBuilder
    func addSpace<Content>(_ space: CGFloat, content: @escaping () -> Content) -> some View where Content: View {
        Spacer(minLength: space)
        content()
        Spacer(minLength: space)
    }
}
