//
//  CreationViewSelector.swift
//  PassMaster
//
//  Created by aleuts on 16/03/2021.
//

import SwiftUI

struct CreateAccountSwitch: View {
    @Binding var selectedAccount : AccountType
    
    var body: some View {
        switch selectedAccount {
        
        case .Password:
            PasswordCreationView()
            
        case .Card:
            CardCreationView()
            
        case .Note:
            NoteCreationView()
        }
    }
}
