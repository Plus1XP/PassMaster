//
//  PasswordEditView.swift
//  PassMaster
//
//  Created by aleuts on 07/03/2021.
//

import SwiftUI

struct PasswordEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var model: AccountStore
    @Binding var selection: PasswordModel
    @State var isShowingAlert = false
    
    var body: some View {
        NavigationView {
            Form{
                PasswordEditForm(account: $selection)
                
                Section() {
                    DeleteAccountButton(isShowingAlert: $isShowingAlert, accountName: selection.name, function: {
                        model.RemovePassword(id: selection.id)
                    })
                }
            }.navigationBarTitle(Text(selection.name))
            .navigationBarItems(
                leading:
                    Button(action: {
                            presentationMode.wrappedValue.dismiss()
                    }) {
                        DismissButton()
                    },
                trailing:
                    Button(action: {
                        self.model.EditPassword(modified: selection)
                        
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        SaveButton()
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
