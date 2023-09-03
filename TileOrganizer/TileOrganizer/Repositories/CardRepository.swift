//
//  CardRepository.swift
//  TileOrganizer
//

import SwiftUI

struct CardsRepository {

    func getCards(amount: Int) -> [Card] {
        (0..<amount)
            .compactMap { _ in
                guard let randomElement = Array(0x1F300...0x1F3F0).randomElement(),
                      let content = UnicodeScalar(randomElement) else {
                    return nil
                }
                return content
            }
            .map { Card(content: String($0)) }
    }
}
