//
//  AccountProcessor.swift
//  PassMaster
//
//  Created by aleuts on 25/02/2021.
//

import Foundation

class AccountProcessor : ObservableObject{
    
    @Published var Passwords: [PasswordModel]
    @Published var Cards: [CardModel]
    @Published var Notes: [NoteModel]

    @Published var Accounts: [AccountType] = [AccountType.Password, AccountType.Card, AccountType.Note]
    
    init() {
        self.Passwords = [ PasswordModel(id: 1, AccountType: AccountType.Password, name: "Tesco", userName: "JTesco@gmail.com", password: "GetmeF00d!", uRL: "www.Tesco.com", notes: "Food is nice"),
                     PasswordModel(id: 2, AccountType: AccountType.Password, name: "John Lewis", userName: "JSains@gmail.com", password: "GetmeF00d!", uRL: "www.johnlewis.com"),
                     PasswordModel(id: 3, AccountType: AccountType.Password, name: "Fitness First", userName: "Gunter@gmail.com", password: "GetmeF00d!", notes: "Just happy to be here")]
        
        self.Cards = [CardModel(id: 1, AccountType: AccountType.Card, name: "Visa", number: 5555123456789900, start: "Jan 19", end: "Dec 22", cvv: 313),
                       CardModel(id: 2, AccountType: AccountType.Card, name: "Mastercard", number: 5555123456789900, start: "Jan 19", end: "Dec 22", cvv: 313),
                       CardModel(id: 3, AccountType: AccountType.Card, name: "AMEX", number: 5555123456789900, end: "Dec 22", cvv: 313)]
        
        self.Notes = [NoteModel(id: 1, AccountType: AccountType.Note, title: "Card Pins", body: "Visa - 1234"),
                      NoteModel(id: 2, AccountType: AccountType.Note, title: "Todo", body: "Go Gym!"),
                      NoteModel(id: 3, AccountType: AccountType.Note, title: "Call Doctor", body: "Tell him about PAIN")]
    }
    
    var accounts = [PasswordModel]()
    
    func AddAccount(account : PasswordModel) -> Void{
        
        accounts.append(account)
    }
    
    func RemoveAccount(account : PasswordModel) -> Void {
        
        for item in accounts {
            var count = 0
            if item.id == account.id {
                accounts.remove(at: count)
            }
            count += 1
        }
    }
    
    /*
    func FindAccount(name : String) -> AccountModel{
        
        return accounts.firstIndex(of: name)
    }
    */
    
    func GetNewAccountId() -> Int {
        
        //return accounts.count + 1
        return accounts.last?.id ?? 0 + 1
    }
}
