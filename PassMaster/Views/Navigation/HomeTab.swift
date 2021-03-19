//
//  MenuBarView.swift
//  PassMaster
//
//  Created by aleuts on 11/03/2021.
//

import SwiftUI

struct HomeTab: View {
    @EnvironmentObject var model: AccountStore
    @Binding var selectedAccount: AccountType
    
    var body: some View {
        Picker("Select Account", selection: $selectedAccount) {
            ForEach(model.Accounts, id: \.self) { account in
                Button(
                    action: {
                        self.selectedAccount = account
                    },
                    label: {
                        Text(account.rawValue)
                    })
            }
        }
    }
}

struct HomeTab_Previews: PreviewProvider {
    static var previews: some View {
        HomeTab(selectedAccount: .constant(.Password))
            .previewLayout(.sizeThatFits)
    }
}
