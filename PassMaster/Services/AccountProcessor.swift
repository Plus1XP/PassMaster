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
    
    func AddPassword(name: String, userName: String, password: String, memorable: String?, AccountNo: String?, uRL: String?, notes: String?) -> Void{
        
        let id = GetNewPasswordId()
        let accountType = AccountType.Password
        
        let account = PasswordModel(
                                    id: id,
                                    AccountType: accountType,
                                    name: name,
                                    userName: userName,
                                    password: password,
                                    memorable: memorable,
                                    accountNo: AccountNo,
                                    uRL: uRL,
                                    notes: notes)
        Passwords.append(account)
    }
    
    func AddCard(name: String, number: String, start: String?, end: String, cvv: String, notes: String?) -> Void{
        
        let id = GetNewCardId()
        let accountType = AccountType.Card
        
        let account: [CardModel] = [CardModel(
                                            id: id,
                                            AccountType: accountType,
                                            name: name,
                                            number: Int(number) ?? 0,
                                            start: start,
                                            end: end,
                                            cvv: Int(cvv) ?? 0,
                                            note: notes)]
        
        Cards.append(contentsOf: account)
    }
    
    func AddNote(title: String, body: String) -> Void{
        
        let id = GetNewNoteId()
        let accountType = AccountType.Note
        
        let account: [NoteModel] = [NoteModel(
                                            id: id,
                                            AccountType: accountType,
                                            title: title,
                                            body: body)]
        
        Notes.append(contentsOf: account)
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
    
    func RemovePassword(id: Int) {
        
        let index = Passwords.firstIndex(where: {$0.id == id}) ?? 0
        print("Index:", index)
        Passwords.remove(at: index)
    }
    
    func RemoveCard(id: Int) {
        
        let index = Cards.firstIndex(where: {$0.id == id}) ?? 0
        
        Cards.remove(at: index)
    }
    
    func RemoveNote(id: Int) {
        
        let index = Notes.firstIndex(where: {$0.id == id}) ?? 0
        
        Notes.remove(at: index)
    }
    
    func EditPassword(id: Int, name: String, userName: String, password: String, memorable: String?, AccountNo: String?, uRL: String?, notes: String?) -> Void{

        let index = Passwords.firstIndex(where: {$0.id == id})

        let accountType = AccountType.Password
        
        let account = PasswordModel(
                                id: id,
                                AccountType: accountType,
                                name: name,
                                userName: userName,
                                password: password,
                                memorable: memorable,
                                accountNo: AccountNo,
                                uRL: uRL,
                                notes: notes)
        
        Passwords[index ?? 0] = account
    }
    
    func EditCard(id: Int, name: String, number: Int, start: String?, end: String, cvv: Int, notes: String?) -> Void{
        
        let index = Cards.firstIndex(where: {$0.id == id})
        
        let accountType = AccountType.Card
        
        let account = CardModel(
                            id: id,
                            AccountType: accountType,
                            name: name,
                            number: number,
                            start: start,
                            end: end,
                            cvv: number,
                            note: notes)
        
        Cards[index ?? 0] = account
    }
    
    func EditNote(id: Int, title: String, body: String) -> Void{
        
        let index = Notes.firstIndex(where: {$0.id == id})

        let accountType = AccountType.Note
        
        let account = NoteModel(
                            id: id,
                            AccountType: accountType,
                            title: title,
                            body: body)
        
        Notes[index ?? 0] = account
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
    
    func GetNewPasswordId() -> Int {
        
        var total: Int = 0
        let current: Int = Passwords.last?.id ?? 0
        total = current + 1
        print("Current items:", current)
        print("Total items:", total)
        return total
    }
    
    func GetNewCardId() -> Int {
        
        return (Cards.last?.id ?? 0) + 1
    }
    
    func GetNewNoteId() -> Int {

        let current: Int = Notes.last?.id ?? 0
        print("Current items:", current)
        return current + 1
    }
}
