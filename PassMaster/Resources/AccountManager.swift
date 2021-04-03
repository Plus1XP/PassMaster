//
//  AccountManager.swift
//  PassMaster
//
//  Created by aleuts on 25/03/2021.
//

import Foundation

class AccountManager: ObservableObject {
    let manager: FileManager
    let encoder = JSONEncoder()
    let passmasterDirName: String
    let passmasterFileName: String
    
    init() {
        self.manager = FileManager.default
        self.encoder.outputFormatting = .prettyPrinted
        self.passmasterDirName = "PassMaster"
        self.passmasterFileName = "accounts.json"
    }
    
    func GetDocumentsUrl() -> URL {
        let path = manager.urls(for: .documentDirectory,
                                 in: .userDomainMask)
        let documentsDirectory = path[0]
        return documentsDirectory
    }
    
    func GetPassMasterUrl() -> URL {
        let passmasterDirectory = GetDocumentsUrl().appendingPathComponent(passmasterDirName)
        return passmasterDirectory
    }
    
    func GetPassMasterFileUrl() -> URL {
        let file = GetPassMasterUrl().appendingPathComponent(passmasterFileName)
        return file
    }
}
