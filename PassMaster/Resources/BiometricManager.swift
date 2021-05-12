//
//  BiometricManager.swift
//  PassMaster
//
//  Created by aleuts on 29/05/2021.
//

import LocalAuthentication

class BiometricManager: ObservableObject {
    @Published var isUnlocked = false
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                DispatchQueue.main.async {
                    if success {
                        print("authentication sucessful")
                        self.isUnlocked = true
                    } else {
                        // there was a problem
                        print("authentication failed")
                    }
                }
            }
        } else {
            // no biometrics
            print("authentication not available")
        }
    }
}
