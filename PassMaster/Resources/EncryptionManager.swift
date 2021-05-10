//
//  EncryptionManager.swift
//  PassMaster
//
//  Created by aleuts on 25/04/2021.
//

import Foundation
import CryptoKit

class EncryptionManager {
    let key = SymmetricKey(size: .bits256)
    let nonce = try! AES.GCM.Nonce(data: Data(base64Encoded: "fv1nixTVoYpSvpdA")!)
    let tag = Data(base64Encoded: "e1eIgoB4+lA/j3KDHhY4BQ==")!
    
    func EncryptText(plainText: String) -> String {
        //let sealedBox = try! AES.GCM.seal(plainText.data(using: .utf8)!, using: key)
        //return (sealedBox.combined!.base64EncodedString())

        let sealedBox = try! AES.GCM.seal(plainText.data(using: .utf8)!, using: key, nonce: nonce, authenticating: tag)
        print("Nonce:\n\(nonce.withUnsafeBytes { Data(Array($0)).base64EncodedString() })\n")
        print("Tag:\n\(tag.base64EncodedString())\n")
        print("Cipher Text:\n\(sealedBox.ciphertext.base64EncodedString())\n")
        return (sealedBox.ciphertext.base64EncodedString())
    }
    
    func DecryptText(cipherText:String) -> String {
        //let sealedBoxRestored = try! AES.GCM.SealedBox(combined: Data(base64Encoded: cipherText)!)
        print("Nonce:\n\(nonce.withUnsafeBytes { Data(Array($0)).base64EncodedString() })\n")
        print("Tag:\n\(tag.base64EncodedString())\n")
        print("Cipher Text:\n\(cipherText)\n")
        let sealedBoxRestored = try! AES.GCM.SealedBox(nonce: nonce, ciphertext: Data(base64Encoded: cipherText)!, tag: tag)
        let decrypted = try! AES.GCM.open(sealedBoxRestored, using: key)
        return (String(data: decrypted, encoding: .utf8)!)
    }
}

/*
// Encrypt: Using plain text only • nonce & tag are randomly created
/// Decrypt: Specify all 3 parameters: nonce + cipher text + tag
func cryptoDemoCipherText() {
    
    // Encrypt
    let sealedBox = try! AES.GCM.seal(plain.data(using: .utf8)!, using: key)
    
    // Decrypt
    let sealedBoxRestored = try! AES.GCM.SealedBox(nonce: sealedBox.nonce, ciphertext: sealedBox.ciphertext, tag: sealedBox.tag)
    let decrypted = try! AES.GCM.open(sealedBoxRestored, using: key)
    
    print("Crypto Demo I\n••••••••••••••••••••••••••••••••••••••••••••••••••\n")
    print("Combined:\n\(sealedBox.combined!.base64EncodedString())\n")
    print("Cipher:\n\(sealedBox.ciphertext.base64EncodedString())\n")
    print("Nonce:\n\(sealedBox.nonce.withUnsafeBytes { Data(Array($0)).base64EncodedString() })\n")
    print("Tag:\n\(sealedBox.tag.base64EncodedString())\n")
    print("Decrypted:\n\(String(data: decrypted, encoding: .utf8)!)\n")
}

/// Encrypt: Specify all 3 parameters yourself: nonce + cipher text + tag
/// Decrypt: Using combined data (nonce + cipher text + tag) and tag to open
func cryptoDemoCombinedData() {
    
    let nonce = try! AES.GCM.Nonce(data: Data(base64Encoded: "fv1nixTVoYpSvpdA")!)
    let tag = Data(base64Encoded: "e1eIgoB4+lA/j3KDHhY4BQ==")!
    
    // Encrypt
    let sealedBox = try! AES.GCM.seal(plain.data(using: .utf8)!, using: key, nonce: nonce, authenticating: tag)
    
    // Decrypt
    let sealedBoxRestored = try! AES.GCM.SealedBox(combined: sealedBox.combined!)
    let decrypted = try! AES.GCM.open(sealedBoxRestored, using: key, authenticating: tag)
    
    print("Crypto Demo II\n••••••••••••••••••••••••••••••••••••••••••••••••••\n")
    print("Combined:\n\(sealedBox.combined!.base64EncodedString())\n")
    print("Cipher:\n\(sealedBox.ciphertext.base64EncodedString())\n")
    print("Nonce:\n\(nonce.withUnsafeBytes { Data(Array($0)).base64EncodedString() })\n")
    print("Tag:\n\(tag.base64EncodedString())\n")
    print("Decrypted:\n\(String(data: decrypted, encoding: .utf8)!)\n")
}
*/
