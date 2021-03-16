//
//  AccountModel.swift
//  PassMaster
//
//  Created by aleuts on 25/02/2021.
//

import Foundation

struct PasswordModel: Identifiable, Hashable {
    var id : Int
    var AccountType: AccountType
    var name : String
    var userName : String
    var password : String
    var memorable: String?
    var accountNo: String?
    var uRL : String?
    var note : String?
    
    static let `mock` = Self(id: 0, AccountType: .Password, name: "example", userName: "example@example.com", password: "password123", memorable: "Rover",
                             accountNo: "EX12345", uRL: "www.example.com", note: "Work Account")    
    static let `empty` = Self(id: 0, AccountType: .Password, name: "", userName: "", password: "", memorable: "", accountNo: "", uRL: "", note: "")
    
//    init() {
//
//    }
//
//    init(userName: String, password: String, memorable: String?, accountNo: String?, uRL: String?, notes: String?) {
//        self.name = userName
//        self.password = password
//        self.memorable = memorable
//        self.accountNo = accountNo
//        self.uRL = uRL
//        self.notes = notes
//    }
    
    //let accounts = [AccountModel]()
    
//    init(id: Int, name: String, userName: String, password: String, uRL: String, notes: String) {
//        self.id = id
//        self.name = name
//        self.userName = userName
//        self.password = password
//        self.uRL = uRL
//        self.notes = notes
//    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(AccountType)
        hasher.combine(name)
        hasher.combine(userName)
        hasher.combine(password)
        hasher.combine(uRL)
        hasher.combine(note)
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
