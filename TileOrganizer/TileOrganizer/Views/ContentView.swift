//
//  ContentView.swift
//  TileOrganizer
//

import SwiftUI
import Combine

struct ContentView: View {

    // MARK: - Constants

    private let tileSize = CGSize(width: 100, height: 150)
    private let numberOfPresentedCards: Int = 10

    // MARK: - Repository

    private var cardsRepository = CardsRepository()

    // MARK: - States

    @State private var cardsList: [Card]
    @State private var selectedCards: [Card] = []

    // MARK: - Init

    init() {
        _cardsList = State(initialValue: cardsRepository.getCards(amount: numberOfPresentedCards))
    }

    // MARK: - UI

    var body: some View {
        GeometryReader { geometry in
            addNavigation(content: {
                ScrollView {
                    let spacing = geometry.size.width / 6
                    addSpace(spacing) {
                        addCards(spaceBetween: spacing, cardSelected: updateSelectedList(with:))
                            .onChange(of: cardsList) { currentCards in
                                self.generateCards(based: currentCards)
                            }
                    }
                }
            }, buttonAction: {
                withAnimation {
                    mergeCards()
                }
            })
        }
    }
}

// MARK: - Cards process

private extension ContentView {

    func mergeCards() {
        selectedCards.removeFirst()
            .update(properties: {
                $0.isSelected = false
                $0.isStacked = true
            })
        cardsList.removeAll(where: { selectedCards.contains($0) })
        selectedCards.removeAll()
    }

    func generateCards(based onCurrent: [Card]) {
        cardsList.append(
            contentsOf: cardsRepository.getCards(amount: numberOfPresentedCards - onCurrent.count)
        )
    }

    func updateSelectedList(with card: Card) {
        card.isSelected.toggle()
        if selectedCards.contains(card) {
            selectedCards.removeAll(where: { $0 == card })
        } else {
            selectedCards.append(card)
        }
    }
}

// MARK: - View management

private extension ContentView {
    @ViewBuilder
    func addCards(spaceBetween: CGFloat, cardSelected: @escaping (Card) -> Void) -> some View {
        let columns = Array(
            repeating: GridItem(.fixed(tileSize.width), spacing: spaceBetween),
            count: 2
        )
        LazyVGrid(columns: columns, spacing: spaceBetween) {
            ForEach(cardsList) { card in
                CardView(card: card)
                    .frame(height: tileSize.height)
                    .onTapGesture {
                       cardSelected(card)
                    }
            }
        }
    }
    
    @ViewBuilder
    func addNavigation<Content>(content: @escaping () -> Content,
                                buttonAction: @escaping () -> Void) -> some View where Content: View {
        NavigationStack {
            content()
                .navigationTitle("Select And Merge")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button("Merge") {
                        buttonAction()
                    }
                    .disabled(selectedCards.count <= 1)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
