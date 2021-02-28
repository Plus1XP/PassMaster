//
//  AccountProcessor.swift
//  PassMaster
//
//  Created by aleuts on 25/02/2021.
//

import Foundation

class AccountProcessor : ObservableObject{
    
    @Published var logins = ["Gmail", "Hotmail", "Yahoo"]
    
    @Published var cards = ["Amex", "Visa", "MasterCard"]
    
    @Published var superMarkets: [AccountModel]
    
    init() {
        self.superMarkets = [ AccountModel(id: 1, name: "Tesco", userName: "JTesco@gmail.com", password: "GetmeF00d!", uRL: "www.Tesco.com", notes: "Food is nice"),
                     AccountModel(id: 2, name: "Sainsburrys", userName: "JSains@gmail.com", password: "GetmeF00d!", uRL: "www.sainsburrys.com", notes: "Food is nice"),
                     AccountModel(id: 3, name: "Lidl", userName: "Gunter@gmail.com", password: "GetmeF00d!", uRL: "www.lidl.com", notes: "Food is nice")]
    }
    
    var accounts = [AccountModel]()
    
    func AddAccount(account : AccountModel) -> Void{
        
        accounts.append(account)
    }
    
    func RemoveAccount(account : AccountModel) -> Void {
        
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
