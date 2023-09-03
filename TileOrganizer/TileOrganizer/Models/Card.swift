//
//  Card.swift
//  TileOrganizer
//

import SwiftUI

final class Card: ObservableObject, Identifiable {

    // MARK: - Published properties

    @Published var isSelected: Bool
    @Published var isStacked: Bool

    // MARK: - Properties

    let id = UUID()
    let content: String

    // MARK: - Init

    init(content: String, isSelected: Bool = false, isStacked: Bool = false) {
        self.content = content
        self.isSelected = isSelected
        self.isStacked = isStacked
    }

    func update(properties closure: (Card) -> Void) {
        closure(self)
    }
}

extension Card: Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.id == rhs.id
    }
}
