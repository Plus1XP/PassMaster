//
//  CreationView.swift
//  PassMaster
//
//  Created by aleuts on 27/02/2021.
//

import SwiftUI

struct CreationView: View {
    @State private var name = ""
    @State private var user = ""
    @State private var pass = ""
    @State private var url = ""
    @State private var notes = ""

    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Enter New Account Information")) {
                    TextField("Account Name", text: $name)
                    TextField("Username", text: $user).keyboardType(.emailAddress)
                    TextField("Password", text: $pass)
                    TextField("URL", text: $url).keyboardType(.URL)
                    TextField("Notes", text: $notes)
                }
            }.navigationBarTitle(Text(name)).navigationBarItems(leading: Button("Cancel") {
                
            }, trailing: Button("Save") {
                
            })
        }
    }
}

struct CreationView_Previews: PreviewProvider {
    static var previews: some View {
        CreationView()
    }
}