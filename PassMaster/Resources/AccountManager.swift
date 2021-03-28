//
//  AccountManager.swift
//  PassMaster
//
//  Created by aleuts on 25/03/2021.
//

import Foundation

class AccountManager: ObservableObject {
    
    let manager: FileManager
    let passmasterDirName: String
    let passmasterFileName: String
    
    init() {
        self.manager = FileManager.default
        self.passmasterDirName = "PassMaster"
        self.passmasterFileName = "accounts.json"
    }
    
}
