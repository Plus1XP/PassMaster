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
    
    //Temporarily set file to var
    var passmasterFileName: String
    
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
    
    func RemoveFile(url: URL) -> Void {
        if manager.fileExists(atPath: url.path)
        {
            do {
                try manager.removeItem(at: url)
            }
            catch {
                print(error)
            }
        }
    }
    
    func GetStringFromData(url: URL) -> String {
        let data = manager.contents(atPath: url.path)!
        return data.base64EncodedString()
    }
    
    func GetDataFromString(data: String) -> Data {
        let localData = data.data(using: .utf8)!
        return localData
    }
    
    func SetAccountData<T: Codable>(collectionKeyName: String, accountModel: [T]) -> Void {
        let collectionStore = [collectionKeyName: accountModel]
        
        //Temporarily set file name to collectioname
        passmasterFileName = String(collectionKeyName + ".json")
        
        if !manager.fileExists(atPath: GetPassMasterFileUrl().path) {
            CreateJSONFromStore(collectionStore: collectionStore)
        } else {
            var isCollectionUpdated = false
            var isCollectionMissing = false
            let RootJSONArray: [[String:[T]]] = ReadJSON(accountModel: accountModel)
            for index in RootJSONArray.indices {
                if RootJSONArray[index].first?.key == collectionKeyName {
                    UpdateJSONFromStore(collectionKeyName: collectionKeyName, accountModel: accountModel, RootJSONArray: RootJSONArray, index: index)
                    isCollectionUpdated = true
                    //break
                } else {
                    isCollectionMissing = true
                }
            }
            if isCollectionMissing == true && isCollectionUpdated == false{
                AddToJSONFromStore(RootJSONArray: RootJSONArray, collectionStore: collectionStore)
            }
        }
    }
    
    func CreateJSONFromStore<T: Codable>(collectionStore: [String:[T]]) -> Void {
        let RootJSONArray = [collectionStore]
        //let data = try! encoder.encode(RootJSONArray)
        var data: Data? = nil
        do {
            data = try encoder.encode(RootJSONArray)
        } catch {
            print("Create JSON Failed")
        }
        CreateFile(url: GetPassMasterFileUrl(), data: data!)
    }
    
//    func CreateStructuredJSON() -> Void {
//        let RootJSONArray = ["Passwords":[PasswordModel.empty],"Cards":[CardModel.empty],"Notes":[NoteModel.empty]]
//        //let data = try! encoder.encode(RootJSONArray)
//        var data: Data? = nil
//        do {
//            data = try encoder.encode(RootJSONArray)
//        } catch {
//            print("Create JSON Failed")
//        }
//        CreateFile(url: GetPassMasterFileUrl(), data: data!)
//    }
    
    func UpdateJSONFromStore<T: Codable>(collectionKeyName: String, accountModel: [T], RootJSONArray: [[String:[T]]], index: Int) -> Void {
        var RootJSONArray = RootJSONArray
        RootJSONArray[index][collectionKeyName] = accountModel
        //let data = try! encoder.encode(RootJSONArray)
        var data: Data? = nil
        do {
            data = try encoder.encode(RootJSONArray)
        } catch {
            print("Update JSON Failed")
        }
        RemoveFile(url: GetPassMasterFileUrl())
        CreateFile(url: GetPassMasterFileUrl(), data: data!)
    }
    
    func AddToJSONFromStore<T: Codable>(RootJSONArray: [[String:[T]]], collectionStore: [String:[T]]) -> Void {
        var RootJSONArray = RootJSONArray
        RootJSONArray.append(collectionStore)
        //let data = try! encoder.encode(RootJSONArray)
        var data: Data? = nil
        do {
            data = try encoder.encode(RootJSONArray)
        } catch {
            print("Add to JSON Failed")
        }
        RemoveFile(url: GetPassMasterFileUrl())
        CreateFile(url: GetPassMasterFileUrl(), data: data!)
    }
    
    func GetAccountData<T: Codable>(collectionKeyName: String, collectionStore: inout [T]) -> Void {
        
        //Temporarily set file name to collectioname
        passmasterFileName = String(collectionKeyName + ".json")
        
        let RootJSONArray = ReadJSON(accountModel: collectionStore)
        for index in RootJSONArray.indices {
            if RootJSONArray[index].first?.key == collectionKeyName {
                collectionStore = GetCollectionValues(collectionKeyName: collectionKeyName, collectionStore: RootJSONArray[index])
            }
        }
    }
    
    func GetAccountData<T: Codable>(collectionKeyName: String, collectionStore: [T]) -> [T] {
        
        //Temporarily set file name to collectioname
        passmasterFileName = String(collectionKeyName + ".json")
        
        var collectionStore = collectionStore
        let RootJSONArray = ReadJSON(accountModel: collectionStore)
        for index in RootJSONArray.indices {
            if RootJSONArray[index].first?.key == collectionKeyName {
                collectionStore = GetCollectionValues(collectionKeyName: collectionKeyName, collectionStore: RootJSONArray[index])
            }
        }
        return collectionStore
    }
    
    /*
    func ReadJSON<T: Codable>(accountModel: [T]) -> [[String:[T]]] {
        
        var RawJSONArray: [[String:[T]]] = [[:]]
        let JsonPath = GetPassMasterFileUrl().path
        let data = manager.contents(atPath: JsonPath)!
        let decoder = JSONDecoder()
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        var array: [T]? = nil
        var array2: [String:[T]] = [:]
        var data2: Data? = nil
        
        for collection in json as! [Dictionary<String,Any>] {
//            RawJSONArray!.append(collection as! [String : [T]])
//            RawJSONArray![0] = collection as! [String : [T]]
            
            if let pass = collection["Passwords"] as? [String:[T]] {
                var array2 = pass
            }
            
            
            
            for store in collection {
                                
                if store.key as? String == "Passwords" {

                    let jsonData = try! JSONEncoder().encode(store.value)
                    print(jsonData)
                    
                    
//                    array2 = store as? [String:[T]]
                    
//                    data2 = try encoder.encode(store)
                    
//                    var array2 = store.value as? NSArray
//                    array = array2 as? [T]
                    print("WORKING")
                }
//                if store.key as! String == "Passwords" {
//                    print(store.value)
//                    var val = store.value
//                    array = store.value as! [T]
//                }
            }
        }
//        if let password = json as? [String: Any] {
//            if let yield = password["Passwords"] as? Int {
//                //recipeObject.yield = yield
//            }
//        }
        
//        var RawJSONArray: [[String:[T]]]? = nil
//        if manager.fileExists(atPath: GetPassMasterFileUrl().path) {
//            let JsonPath = GetPassMasterFileUrl().path
//            let data = manager.contents(atPath: JsonPath)!
//            let decoder = JSONDecoder()
//            //return try! decoder.decode([[String:[T]]].self, from: data)
//            do {
//                RawJSONArray = try decoder.decode([[String:[T]]].self, from: data)
//            } catch {
//                print("Read Raw JSON Failed")
//            }
//        }
        return RawJSONArray ?? [["ERROR":[T].init()]]
    }
    */
    func ReadJSON<T: Codable>(accountModel: [T]) -> [[String:[T]]] {
        var RawJSONArray: [[String:[T]]] = [[:]]
        if manager.fileExists(atPath: GetPassMasterFileUrl().path) {
            let JsonPath = GetPassMasterFileUrl().path
            if let data = manager.contents(atPath: JsonPath) {
                let decoder = JSONDecoder()
                do {
                    RawJSONArray = try decoder.decode([[String:[T]]].self, from: data)
                } catch {
                    print("Read Raw JSON Failed")
                }
            } else {
                print("File Error")
            }
        }
        return RawJSONArray
    }
    
    
//    func ReadJSON<T: Codable>(accountModel: [T]) -> [[String:[T]]] {
//        var RawJSONArray: [[String:[T]]]? = nil
//        if manager.fileExists(atPath: GetPassMasterFileUrl().path) {
//            let JsonPath = GetPassMasterFileUrl().path
//            let data = manager.contents(atPath: JsonPath)!
//            let decoder = JSONDecoder()
//            //return try! decoder.decode([[String:[T]]].self, from: data)
//            do {
//                RawJSONArray = try decoder.decode([[String:[T]]].self, from: data)
//            } catch {
//                print("Read Raw JSON Failed")
//            }
//        }
//        return RawJSONArray ?? [["ERROR":[T].init()]]
//    }
    
    func GetCollectionValues<T>(collectionKeyName: String, collectionStore: [String:[T]]) -> [T] {
        var accountModel: [T] = [T].init()
        for key in collectionStore.keys {
            if key == collectionKeyName {
                for value in collectionStore.values {
                    accountModel.append(contentsOf: value)
                }
            }
        }
        return accountModel
    }
}
