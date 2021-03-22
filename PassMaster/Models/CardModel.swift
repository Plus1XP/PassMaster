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
    var startMonth: String?
    var startYear: String?
    var endMonth: String
    var endYear: String
    var cvv: String
    var note: String?
    
    static let `mock` = Self(id: 0, AccountType: .Card, name: "example", number: "5105105105105100", startMonth: "Jan", startYear: "2021", endMonth: "DEC", endYear: "2024", cvv: "123", note: "Petty Cash")
    static let `empty` = Self(id: 0, AccountType: .Card, name: "", number: "", startMonth: "", startYear: "", endMonth: "", endYear: "", cvv: "", note: "")
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(AccountType)
        hasher.combine(name)
        hasher.combine(number)
        hasher.combine(startMonth)
        hasher.combine(startYear)
        hasher.combine(endMonth)
        hasher.combine(endYear)
        hasher.combine(cvv)
        hasher.combine(note)
    }
    
    func equals(_ CompareTo: CardModel) -> Bool {
        return
            self.id == CompareTo.id &&
            self.AccountType == CompareTo.AccountType &&
            self.name == CompareTo.name &&
            self.number == CompareTo.number &&
            self.startMonth == CompareTo.startMonth &&
            self.startYear == CompareTo.startYear &&
            self.endMonth == CompareTo.endMonth &&
            self.endYear == CompareTo.endYear &&
            self.cvv == CompareTo.cvv &&
            self.note == CompareTo.note
    }
}
