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
    
    func CreateDirectory(url: URL) -> Void {
        do {
            try manager.createDirectory(
                at: url,
                withIntermediateDirectories: true,
                attributes: [:]
            )
        }
        catch {
            print(error)
        }
    }
    
    func CreateFile(url: URL, data: Data) -> Void {
        if !manager.fileExists(atPath: url.path)
        {
            manager.createFile(atPath: url.path,
                               contents: data,
                               attributes: nil)
        }
    }
    
    func AppendFile(url: URL, data: Data) -> Void {
        if manager.fileExists(atPath: url.path) {
            let updater = try? FileHandle(forUpdating: url)
            updater?.seekToEndOfFile()
            updater?.write(data)
            updater?.closeFile()
        }
    }
}
