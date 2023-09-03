//
//  CardView.swift
//  TileOrganizer
//

import SwiftUI

struct CardView: View {

    // MARK: - Observed properties

    @ObservedObject var card: Card

    // MARK: - UI

    var body: some View {
        renderedContent
            .animation(.linear(duration: 0.3), value: card.isSelected)
            .animation(.linear(duration: 0.3), value: card.isStacked)
            .transition(.opacity)
    }
}

private extension CardView {

    // MARK: - UI

    @ViewBuilder
    var renderedContent: some View {
        if card.isStacked {
            addStack()
        } else {
            addSingle()
        }
    }

    func addStack(amount: Int = 2) -> some View {
        ZStack {
            ForEach((0..<amount), id: \.self) { index in
                addSingle(index * 5)
            }
        }
    }

    func addSingle(_ degreesRotation: Int = 0) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(
                    Color(card.isSelected ? "CardBackgroundSelected" : "CardBackgroundDefault"),
                    style: StrokeStyle(lineWidth: 0.5)
                )
            Text("\(card.content)")
                .foregroundColor(.black)
                .font(.title2)
        }
        .rotationEffect(Angle(degrees: Double(degreesRotation)))
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(content: "1"))
    }
}
