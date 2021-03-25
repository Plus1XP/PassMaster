//
//  PasswordCreationView.swift
//  PassMaster
//
//  Created by aleuts on 07/03/2021.
//

import SwiftUI

struct PasswordCreationView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var passwordStore: PasswordStore
    @State private var password: PasswordModel = PasswordModel.empty
    
    var body: some View {
        NavigationView {
            Form{
                PasswordEditForm(account: $password)
            }
            .navigationBarTitle(Text(password.name))
            .navigationBarItems(
                leading:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        DismissLabel()
                    },
                trailing:
                    Button(action: {
                        self.passwordStore.AddPassword(account: password)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        SaveLabel()
                    })
        }
    }
}

struct PasswordCreationView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordCreationView()
            .environmentObject(AccountStore())
    }
}
