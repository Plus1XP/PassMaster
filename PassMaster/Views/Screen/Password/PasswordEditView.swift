//
//  PasswordEditView.swift
//  PassMaster
//
//  Created by aleuts on 07/03/2021.
//

import SwiftUI

struct PasswordEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var passwordStore: PasswordStore
    @Binding var selection: PasswordModel
    @State var isShowingAlert = false
    
    var body: some View {
        NavigationView {
            Form{
                PasswordEditForm(account: $selection)
                
                Section() {
                    DeleteAccountButton(isShowingAlert: $isShowingAlert, accountName: selection.name, function: {
                        passwordStore.RemovePassword(id: selection.id)
                    })
                }
            }.navigationBarTitle(Text(selection.name))
            .navigationBarItems(
                leading:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        DismissLabel()
                    },
                trailing:
                    Button(action: {
                        self.passwordStore.EditPassword(modified: selection)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        SaveLabel()
                    })
        }
    }
}

struct PasswordEditView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordEditView(selection: .constant(PasswordModel.mock))
            .environmentObject(AccountStore())
    }
}
