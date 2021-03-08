//
//  PasswordView.swift
//  PassMaster
//
//  Created by aleuts on 05/03/2021.
//

import SwiftUI

struct PasswordView: View {
    
    @EnvironmentObject var model: AccountProcessor
    
    @State private var selectedLogin: PasswordModel = PasswordModel(id: 0, AccountType: AccountType.Password, name: "Example", userName: "example@example.com", password: "Password!", uRL: "www.example.com", notes: "Change Password")
    
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
                            HStack {
                                Text(String(selectedLogin.id))
                                    .frame(width: 50, height: 50)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .padding(10)
                                VStack(alignment: .leading) {
                                    Text(selectedLogin.name)
                                        .foregroundColor(Color.white)
                                    Text(selectedLogin.userName)
                                        .foregroundColor(Color.white)
                                        .font(.footnote)
                                }
                            }
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
            .environmentObject(AccountProcessor())
    }
}
