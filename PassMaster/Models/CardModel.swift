//
//  CardModel.swift
//  PassMaster
//
//  Created by aleuts on 03/03/2021.
//

import Foundation

struct CardModel: Hashable {
    var id: Int
    var name: String
    var number: Int
    var start: String?
    var end: String
    var cvv: Int
    var note: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(number)
        hasher.combine(start)
        hasher.combine(end)
        hasher.combine(cvv)
        hasher.combine(note)
    }
}
