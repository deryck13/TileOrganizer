//
//  Shape+Additions.swift
//  TileOrganizer
//

import SwiftUI

extension Shape {
    func fill<S:ShapeStyle>(_ fillContent: S, style: StrokeStyle) -> some View {
        ZStack {
            fill(fillContent)
            stroke(style: style)
        }
    }
}
