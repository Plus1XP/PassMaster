//
//  AccountModel.swift
//  PassMaster
//
//  Created by aleuts on 25/02/2021.
//

import Foundation

struct PasswordModel: Identifiable, Hashable, Codable {
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
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(AccountType)
        hasher.combine(name)
        hasher.combine(userName)
        hasher.combine(password)
        hasher.combine(uRL)
        hasher.combine(note)
    }
    
    func equals(_ CompareTo: PasswordModel) -> Bool {
        return
            self.id == CompareTo.id &&
            self.AccountType == CompareTo.AccountType &&
            self.name == CompareTo.name &&
            self.userName == CompareTo.userName &&
            self.password == CompareTo.password &&
            self.memorable == CompareTo.memorable &&
            self.accountNo == CompareTo.accountNo &&
            self.uRL == CompareTo.uRL &&
            self.note == CompareTo.note
    }
}
