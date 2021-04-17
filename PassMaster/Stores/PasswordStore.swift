//
//  PasswordStore.swift
//  PassMaster
//
//  Created by aleuts on 20/03/2021.
//

import Foundation

class PasswordStore : ObservableObject{
    
    @Published var Passwords: [PasswordModel]
    let accountManager: AccountManager
    let collectionKey: String
    
    init() {
        self.Passwords = [PasswordModel].init()
        self.accountManager = AccountManager()
        self.collectionKey = "Passwords"
        self.GetPasswordData()
    }
    
    func GetNewPasswordId() -> Int {
        var total: Int = 0
        let current: Int = Passwords.last?.id ?? 0
        total = current + 1
        return total
    }
    
    func AddPassword(account : PasswordModel) -> Void {
        
        var password: PasswordModel
        password = account
        password.id = GetNewPasswordId()
        password.AccountType = .Password
        
        Passwords.append(password)
    }
    
    func RemovePassword(id: Int) {
        
        let index = Passwords.firstIndex(where: {$0.id == id}) ?? 0
        Passwords.remove(at: index)
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
   
    func RestorePassword(account : PasswordModel) -> Void {
        
        Passwords.append(account)
        Passwords = Passwords.sorted(by: { (first: PasswordModel, second: PasswordModel) -> Bool in
            first.id < second.id
        })
    }
}
