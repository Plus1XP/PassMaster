//
//  PasswordEditView.swift
//  PassMaster
//
//  Created by aleuts on 07/03/2021.
//

import SwiftUI

struct PasswordEditView: View {

    @EnvironmentObject var model: AccountProcessor
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var selection: PasswordModel
    
    @State var isShowingAlert = false
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Edit Account Information")) {
                    TextField("Account Name", text: $selection.name)
                    TextField("Username", text: $selection.userName).keyboardType(.emailAddress)
                    TextField("Password", text: $selection.password)
                    TextField("Memorable Answer", text: $selection.memorable.bound)
                    TextField("Account No.", text: $selection.accountNo.bound)
                    TextField("URL", text: $selection.uRL.bound).keyboardType(.URL)
                    TextField("Notes", text: $selection.notes.bound)
                }.foregroundColor(Color.white)
                
                Section() {
                    Button("Delete Account") {
                        //model.RemovePassword(id: selection.id)
                        self.isShowingAlert = true
                    }.frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        alignment: .center)
                    .alert(isPresented: $isShowingAlert) {
                        Alert(
                            title: Text("Delete \(selection.name)"),
                            message: Text("Confirm \(selection.name) removal"),
                            primaryButton: .destructive(Text("Delete")) {
                                model.RemovePassword(id: selection.id)
                                presentationMode.wrappedValue.dismiss()
                            },
                            secondaryButton: .cancel())
                    }
                }
            }.navigationBarTitle(Text(selection.name))
            .navigationBarItems(
                leading:
                    Button(action: {
                            presentationMode.wrappedValue.dismiss()
                    }) {
                        Label("Disgard", systemImage: "trash")
                    },
                trailing:
                    Button(action: {
                        self.model.EditPassword(id: selection.id, name: selection.name, userName: selection.userName, password: selection.password, memorable: selection.memorable, AccountNo: selection.accountNo, uRL: selection.uRL, notes: selection.notes)
                        
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Label("Save", systemImage: "sdcard")
                    })
        }
    }
}

struct PasswordEditView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordEditView(selection: .constant(PasswordModel(id: 0, AccountType: .Password, name: "example", userName: "example", password: "password", memorable: "maiden name", accountNo: "12345678", uRL: "www.example.com", notes: "Chnage password")))
            .environmentObject(AccountProcessor())
    }
}
