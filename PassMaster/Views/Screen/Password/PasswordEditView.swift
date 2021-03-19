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
//                Section(header: Text("Edit Account Information")) {
//                    TextField("Account Name", text: $selection.name)
//                    TextField("Username", text: $selection.userName).keyboardType(.emailAddress)
//                    TextField("Password", text: $selection.password)
//                    TextField("Memorable Answer", text: $selection.memorable.bound)
//                    TextField("Account No.", text: $selection.accountNo.bound)
//                    TextField("URL", text: $selection.uRL.bound).keyboardType(.URL)
//                    TextField("Notes", text: $selection.notes.bound)
//                }.foregroundColor(Color.white)
                
                Section() {
                    DeleteAccountButton(isShowingAlert: $isShowingAlert, accountName: selection.name, function: {
                        model.RemovePassword(id: selection.id)
                    })
                    
                    //DeleteAlertView(isShowingAlert: $isShowingAlert, accountName: selection.name, function: { model.RemovePassword(id: selection.id) })

                    //.alert(isPresented: $isShowingAlert) {
//                        Alert(
//                            title: Text("Delete \(selection.name)"),
//                            message: Text("Confirm \(selection.name) removal"),
//                            primaryButton: .destructive(Text("Delete")) {
//                                NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: "AccountRemoved")))
//                                model.RemovePassword(id: selection.id)
//                                presentationMode.wrappedValue.dismiss()
//                            },
//                            secondaryButton: .cancel())
                    //}
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
                        self.model.EditPassword(id: selection.id, name: selection.name, userName: selection.userName, password: selection.password, memorable: selection.memorable, AccountNo: selection.accountNo, uRL: selection.uRL, notes: selection.note)
                        
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
