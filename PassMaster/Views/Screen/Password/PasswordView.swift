//
//  PasswordView.swift
//  PassMaster
//
//  Created by aleuts on 05/03/2021.
//

import SwiftUI

struct PasswordView: View {
    @EnvironmentObject var model: AccountStore
    @State private var selectedLogin: PasswordModel = PasswordModel.mock
    @State private var canShowDetailsView = false
    
    var body: some View {
        Form{
            Section(header: Text("Logins & Passwords")){
                List(self.model.Passwords, id: \.self) { selectedLogin in
                    Button(
                        action: {
                            self.selectedLogin = selectedLogin
                            self.canShowDetailsView.toggle()
                        },
                        label: {
                            AccountListForm(id: selectedLogin.id, mainHeader: selectedLogin.name, subHeader: selectedLogin.userName)
                        }).sheet(isPresented: $canShowDetailsView) {
                            PasswordDetailsView(selection: $selectedLogin)
                        }
                }
            }
        }
    }
}

struct PasswordView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordView()
            .environmentObject(AccountStore())
    }
}
