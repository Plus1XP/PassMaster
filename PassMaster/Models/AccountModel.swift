//
//  AccountModel.swift
//  PassMaster
//
//  Created by aleuts on 25/02/2021.
//

import Foundation

struct AccountModel: Identifiable, Hashable {
    var id : Int
    var name : String
    var userName : String
    var password : String
    var uRL : String
    var notes : String
    
    //let accounts = [AccountModel]()
    
    init(id: Int, name: String, userName: String, password: String, uRL: String, notes: String) {
        self.id = id
        self.name = name
        self.userName = userName
        self.password = password
        self.uRL = uRL
        self.notes = notes
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(userName)
        hasher.combine(password)
        hasher.combine(uRL)
        hasher.combine(notes)
    }
    
    /*
    let GetId = {
       var count = 0
        for <#item#> in accounts {
            count += 1
        }
    }
 */
}
