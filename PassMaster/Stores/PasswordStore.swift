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
        //accountManager.set()
        //accountManager.get()

    }
    
    func GetNewPasswordId() -> Int {
        var total: Int = 0
        let current: Int = Passwords.last?.id ?? 0
        total = current + 1
        return total
    }
    
    func GetPasswordData() -> Void {
        self.Passwords = accountManager.GetAccountData(collectionKeyName: collectionKey, collectionStore: Passwords)
    }
    
    func SetPasswordData() -> Void {
        accountManager.SetAccountData(collectionKeyName: collectionKey, accountModel: Passwords)
    }
    
    func AddPassword(account : PasswordModel) -> Void {
        accountManager.get()
        var password: PasswordModel
        password = account
        password.id = GetNewPasswordId()
        password.AccountType = .Password
        
        Passwords.append(password)
        self.SetPasswordData()
    }
    
    func RemovePassword(id: Int) {
        let index = Passwords.firstIndex(where: {$0.id == id}) ?? 0
        Passwords.remove(at: index)
        self.SetPasswordData()
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
            self.SetPasswordData()
        }
    }
   
    func RestorePassword(account : PasswordModel) -> Void {
        Passwords.append(account)
        Passwords = Passwords.sorted(by: { (first: PasswordModel, second: PasswordModel) -> Bool in
            first.id < second.id
        })
        self.SetPasswordData()
    }
}
