//
//  PasswordCreationView.swift
//  PassMaster
//
//  Created by aleuts on 07/03/2021.
//

import SwiftUI

struct PasswordCreationView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var model: AccountStore
    @State private var password: PasswordModel = PasswordModel.empty
    
//    @State private var name = ""
//    @State private var user = ""
//    @State private var pass = ""
//    @State private var mem = ""
//    @State private var accNo = ""
//    @State private var url = ""
//    @State private var notes = ""
    
    var body: some View {
        NavigationView {
            Form{
                //Section(header: Text("Enter New Account Information")) {
                    PasswordEditForm(account: $password)
                //}
            }
            //PasswordEditorView(account: $password)
//            Form{
//                Section(header: Text("Enter New Account Information")) {
//                    TextField("Account Name", text: $password.name)
//                    TextField("Username", text: $password.userName).keyboardType(.emailAddress)
//                    TextField("Password", text: $password.password)
//                    TextField("Memorable Answer", text: $password.memorable.bound)
//                    TextField("Account No.", text: $password.accountNo.bound)
//                    TextField("URL", text: $password.uRL.bound).keyboardType(.URL)
//                    TextField("Notes", text: $password.notes.bound)
//                }
//            }
            .navigationBarTitle(Text(password.name))
            .navigationBarItems(
                leading:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss() }) {
                        DismissButton()
                    },
                trailing:
                    Button(action: {
//                        let password: PasswordModel = PasswordModel(id: 0, AccountType: .Password, name: self.name, userName: self.user, password: self.pass, memorable: self.mem, accountNo: self.accNo, uRL: self.url, notes: self.notes)
                        
                        self.model.AddPassword(account: password)
                        
                        //self.model.AddPassword(name: name, userName: user, password: pass, memorable: mem, AccountNo: accNo, uRL: url, notes: notes)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        SaveButton()
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
