//
//  AccountProcessor.swift
//  PassMaster
//
//  Created by aleuts on 25/02/2021.
//

import Foundation

class AccountStore : ObservableObject{

    @Published var Accounts: [AccountType] = [
        AccountType.Password,
        AccountType.Card,
        AccountType.Note
    ]
}
