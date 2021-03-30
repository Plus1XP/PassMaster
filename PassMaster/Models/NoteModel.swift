//
//  NoteModel.swift
//  PassMaster
//
//  Created by aleuts on 03/03/2021.
//

import Foundation

struct NoteModel: Identifiable, Hashable, Codable {
    var id: Int
    var AccountType: AccountType
    var name: String
    var note: String
    
    static let `mock` = Self(id: 0, AccountType: .Note, name: "example", note: "Secret Note!")
    static let `empty` = Self(id: 0, AccountType: .Note, name: "", note: "")
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(AccountType)
        hasher.combine(name)
        hasher.combine(note)
    }
    
    func equals(_ CompareTo: NoteModel) -> Bool {
        return
            self.id == CompareTo.id &&
            self.AccountType == CompareTo.AccountType &&
            self.name == CompareTo.name &&
            self.note == CompareTo.note
    }
}
