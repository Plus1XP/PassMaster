//
//  ContentView.swift
//  PassMaster
//
//  Created by aleuts on 25/02/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var biometricManager = BiometricManager()
    
//    @StateObject private var authenticationManager = AuthenticationManager()
//    @State private var isAuthenticated = false
    
    var body: some View {
        
        Button(action: {
            print("Button Pushed")
            biometricManager.authenticate()
        }, label: {
            Label("Login", systemImage: "faceid")
        }).fullScreenCover(isPresented: $biometricManager.isUnlocked) {
            HomeView()
        }
    }
        
//        Button(action: {
//            print("authenticate button Pushed")
//            authenticationManager.canEvaluate { (canEvaluate, _, canEvaluateError) in
//                guard canEvaluate else {
//                    // Face ID/Touch ID may not be available or configured
//                    print("authentication not available")
//                    return
//                }
//                authenticationManager.evaluate { (success, error) in
//                    guard success else {
//                        // Face ID/Touch ID may not be configured
//                        print("authentication not configured")
//                        return
//                    }
//                    // You are successfully verified
//                    print("authentication successful")
//                    self.isAuthenticated = true
//                }
//            }
//        }, label: {
//            Label("Login", systemImage: "faceid")
//        }).fullScreenCover(isPresented: self.$isAuthenticated) {
//            HomeView()
//        }
//    }
}
