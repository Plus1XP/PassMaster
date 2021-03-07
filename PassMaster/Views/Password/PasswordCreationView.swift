//
//  PasswordCreationView.swift
//  PassMaster
//
//  Created by aleuts on 07/03/2021.
//

import SwiftUI

struct PasswordCreationView: View {
    
    @EnvironmentObject private var model: AccountProcessor
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var user = ""
    @State private var pass = ""
    @State private var mem = ""
    @State private var accNo = ""
    @State private var url = ""
    @State private var notes = ""
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Enter New Account Information")) {
                    TextField("Account Name", text: $name)
                    TextField("Username", text: $user).keyboardType(.emailAddress)
                    TextField("Password", text: $pass)
                    TextField("Memorable Answer", text: $mem)
                    TextField("Account No.", text: $accNo)
                    TextField("URL", text: $url).keyboardType(.URL)
                    TextField("Notes", text: $notes)
                }
            }.navigationBarTitle(Text(name))
            .navigationBarItems(
                leading:
                    Button(action: {
                            presentationMode.wrappedValue.dismiss() }) {
                        Label("Disgard", systemImage: "trash")
                    },
                trailing:
                    Button(action: {
                        model.AddPassword(name: name, userName: user, password: pass, memorable: mem, AccountNo: accNo, uRL: url, notes: notes)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Label("Save", systemImage: "sdcard")
                    })
        }
    }
}

struct PasswordCreationView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordCreationView()
            .environmentObject(AccountProcessor())
    }
}
