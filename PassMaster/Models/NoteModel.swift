//
//  NoteModel.swift
//  PassMaster
//
//  Created by aleuts on 03/03/2021.
//

import Foundation

struct NoteModel: Hashable {
    var id: Int
    var AccountType: AccountType
    var title: String
    var body: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(AccountType)
        hasher.combine(title)
        hasher.combine(body)
    }
}