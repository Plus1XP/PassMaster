//
//  CardModel.swift
//  PassMaster
//
//  Created by aleuts on 03/03/2021.
//

import Foundation

struct CardModel: Hashable {
    var id: Int
    var AccountType: AccountType
    var name: String
    var number: String
    var start: String?
    var end: String
    var cvv: String
    var note: String?
    
    static let `mock` = Self(id: 0, AccountType: .Card, name: "example", number: "5105105105105100", start: "JAN 21", end: "DEC 24", cvv: "123", note: "Petty Cash")
    static let `empty` = Self(id: 0, AccountType: .Card, name: "", number: "", start: "", end: "", cvv: "", note: "")
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(AccountType)
        hasher.combine(name)
        hasher.combine(number)
        hasher.combine(start)
        hasher.combine(end)
        hasher.combine(cvv)
        hasher.combine(note)
    }
    
    func equals(_ CompareTo: CardModel) -> Bool {
        return
            self.id == CompareTo.id &&
            self.AccountType == CompareTo.AccountType &&
            self.name == CompareTo.name &&
            self.number == CompareTo.number &&
            self.start == CompareTo.start &&
            self.end == CompareTo.end &&
            self.cvv == CompareTo.cvv &&
            self.note == CompareTo.note
    }
}
