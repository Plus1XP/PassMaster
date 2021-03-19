//
//  ViewSelector.swift
//  PassMaster
//
//  Created by aleuts on 11/03/2021.
//

import SwiftUI

struct AccountSwitch: View {
    @Binding var selectedAccount : AccountType
    
    var body: some View {
        switch selectedAccount {
        
        case .Password:
            PasswordView()
            
        case .Card:
            CardView()
            
        case .Note:
            NoteView()
        }
    }
}
