//
//  CardStore.swift
//  PassMaster
//
//  Created by aleuts on 20/03/2021.
//

import Foundation

class CardStore : ObservableObject{
    
    @Published var Cards: [CardModel]

    init() {
    
        self.Cards = [CardModel(id: 1, AccountType: AccountType.Card, name: "Visa", number: "5555123456789900", start: "Jan 19", end: "Dec 22", cvv: "313"),
                      CardModel(id: 2, AccountType: AccountType.Card, name: "Mastercard", number: "5555123456789900", start: "Jan 19", end: "Dec 22", cvv: "313"),
                      CardModel(id: 3, AccountType: AccountType.Card, name: "AMEX", number: "5555123456789900", end: "Dec 22", cvv: "313")]
    }
    
    func GetNewCardId() -> Int {
        
        return (Cards.last?.id ?? 0) + 1
    }
    
    func AddCard(account: CardModel) -> Void {
        
        var card : CardModel
        card = account
        card.id = GetNewCardId()
        card.AccountType = .Card
        
        Cards.append(card)
    }

    func RemoveCard(id: Int) {
        
        let index = Cards.firstIndex(where: {$0.id == id}) ?? 0
        Cards.remove(at: index)
    }
    
    func EditCard(modified: CardModel) -> Void {
        let index = Cards.firstIndex(where: {$0.id == modified.id})
        let original: CardModel = Cards[index ?? 0]
        var temp = modified
        
        if !modified.equals(original) {
            temp.name = modified.name == original.name ? original.name : modified.name
            temp.number = modified.number == original.number ? original.number : modified.number
            temp.start = modified.start == original.start ? original.start : modified.start
            temp.end = modified.end == original.end ? original.end : modified.end
            temp.cvv = modified.cvv == original.cvv ? original.cvv : modified.cvv
            temp.note = modified.note == original.note ? original.note : modified.note
            Cards[index ?? 0] = temp
        }
    }
  
    func RestoreCard(account: CardModel) -> Void {
        Cards.append(account)
        Cards = Cards.sorted(by: {( first: CardModel, second: CardModel) -> Bool in
            first.id < second.id
        })
    }
}