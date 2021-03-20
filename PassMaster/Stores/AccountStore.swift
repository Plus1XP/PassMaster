//
//  AccountProcessor.swift
//  PassMaster
//
//  Created by aleuts on 25/02/2021.
//

import Foundation

class AccountStore : ObservableObject{
    
    @Published var Passwords: [PasswordModel]
    @Published var Cards: [CardModel]
    @Published var Notes: [NoteModel]
    
    @Published var Accounts: [AccountType] = [
        AccountType.Password,
        AccountType.Card,
        AccountType.Note
    ]
    
    init() {
        self.Passwords = [ PasswordModel(id: 1, AccountType: AccountType.Password, name: "Tesco", userName: "JTesco@gmail.com", password: "GetmeF00d!", uRL: "www.Tesco.com", note: "Food is nice"),
                     PasswordModel(id: 2, AccountType: AccountType.Password, name: "John Lewis", userName: "JSains@gmail.com", password: "GetmeF00d!", uRL: "www.johnlewis.com"),
                     PasswordModel(id: 3, AccountType: AccountType.Password, name: "Fitness First", userName: "Gunter@gmail.com", password: "GetmeF00d!", note: "Just happy to be here")]
        
//        self.Cards = [CardModel(id: 1, AccountType: AccountType.Card, name: "Visa", number: 5555123456789900, start: "Jan 19", end: "Dec 22", cvv: 313),
//                       CardModel(id: 2, AccountType: AccountType.Card, name: "Mastercard", number: 5555123456789900, start: "Jan 19", end: "Dec 22", cvv: 313),
//                       CardModel(id: 3, AccountType: AccountType.Card, name: "AMEX", number: 5555123456789900, end: "Dec 22", cvv: 313)]
        self.Cards = [CardModel(id: 1, AccountType: AccountType.Card, name: "Visa", number: "5555123456789900", start: "Jan 19", end: "Dec 22", cvv: "313"),
                      CardModel(id: 2, AccountType: AccountType.Card, name: "Mastercard", number: "5555123456789900", start: "Jan 19", end: "Dec 22", cvv: "313"),
                      CardModel(id: 3, AccountType: AccountType.Card, name: "AMEX", number: "5555123456789900", end: "Dec 22", cvv: "313")]
        
        self.Notes = [NoteModel(id: 1, AccountType: AccountType.Note, name: "Card Pins", note: "Visa - 1234"),
                      NoteModel(id: 2, AccountType: AccountType.Note, name: "Todo", note: "Go Gym!"),
                      NoteModel(id: 3, AccountType: AccountType.Note, name: "Call Doctor", note: "Tell him about PAIN")]
    }
    
    func AddPassword(account : PasswordModel) -> Void {
        
        var password: PasswordModel
        password = account
        password.id = GetNewPasswordId()
        password.AccountType = .Password
        
        Passwords.append(password)
    }
    
    func AddCard(account: CardModel) -> Void {
        
        var card : CardModel
        card = account
        card.id = GetNewCardId()
        card.AccountType = .Card
        
        Cards.append(card)
    }
    
    func AddNote(account: NoteModel) -> Void {
        
        var note: NoteModel
        note = account
        note.id = GetNewNoteId()
        note.AccountType = .Note
        
        Notes.append(note)
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
    
    func EditPassword(modified: PasswordModel) -> Void {
        let index = Passwords.firstIndex(where: {$0.id == modified.id})
        let original: PasswordModel = Passwords[index ?? 0]
        var temp = modified
        
        if !modified.equals(original) {
            temp.name = modified.name == original.name ? original.name : modified.name
            temp.userName = modified.userName == original.userName ? original.userName : modified.userName
            temp.password = modified.password == original.password ? original.password : modified.password
            temp.memorable = modified.memorable == original.memorable ? original.memorable : modified.memorable
            temp.accountNo = modified.accountNo == original.accountNo ? original.accountNo : modified.accountNo
            temp.uRL = modified.uRL == original.uRL ? original.uRL : modified.uRL
            temp.note = modified.note == original.note ? original.note : modified.note
            Passwords[index ?? 0] = temp
        }
    }
    
    func EditCard(modified: CardModel) -> Void {
        let index = Cards.firstIndex(where: {$0.id == modified.id})
        let original: CardModel = Cards[index ?? 0]
        var temp = modified

        if !modified.equals(original) {
            temp.name = modified.name == original.name ? original.name : modified.name
            temp.number = modified.number == original.number ? original.number : modified.number
            temp.start = modified.start == original.start ? original.start : modified.start
            temp.end = modified.end == original.end ? original.end : modified.end
            temp.cvv = modified.cvv == original.cvv ? original.cvv : modified.cvv
            temp.note = modified.note == original.note ? original.note : modified.note
            Cards[index ?? 0] = temp
        }
    }
    
    func EditNote(modified: NoteModel) -> Void {
        let index = Notes.firstIndex(where: {$0.id == modified.id})
        let original: NoteModel = Notes[index ?? 0]
        var temp = modified
        
        if !modified.equals(original) {
            temp.name = modified.name == original.name ? original.name : modified.name
            temp.note = modified.note == original.note ? original.note : modified.note
            Notes[index ?? 0] = temp
        }
    }
    
    func RestorePassword(account : PasswordModel) -> Void {
        
        Passwords.append(account)
        //Passwords = Passwords.sorted(by: { $0.id > $1.id })
        Passwords = Passwords.sorted(by: { (first: PasswordModel, second: PasswordModel) -> Bool in
            first.id < second.id
        })
    }
    
    func RestoreCard(account: CardModel) -> Void {
        Cards.append(account)
        Cards = Cards.sorted(by: {( first: CardModel, second: CardModel) -> Bool in
            first.id < second.id
        })
    }
    
    func RestoreNote(account: NoteModel) -> Void {
        Notes.append(account)
        Notes = Notes.sorted(by: {( first:NoteModel, second: NoteModel) -> Bool in
            first.id < second.id
        })
    }
    
    /*
    func FindAccount(name : String) -> AccountModel{
        
        return accounts.firstIndex(of: name)
    }
    */
    
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
