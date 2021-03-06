//
//  SelectionView.swift
//  PassMaster
//
//  Created by aleuts on 27/02/2021.
//

import SwiftUI

struct SelectionView: View {
    
    @StateObject private var model = AccountProcessor()
    
    @State private var selectedAccount: AccountType = .Password
    
    @State private var canShowCreationView = false
    
    var body: some View {
        NavigationView {
            VStack {
                switch selectedAccount {
                case .Password:
                    PasswordView()
                    
                case .Card:
                    CardView()
                    
                case .Note:
                    NoteView()
                }
            }.navigationBarTitle(Text("PassMaster"))
            .navigationBarItems(trailing:
                                    Button(action: {
                                            self.canShowCreationView.toggle()}) {
                                    Label("Add", systemImage: "plus.circle")
                                }).sheet(isPresented: $canShowCreationView) {
                                    CreationView()
                                }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Picker("Select Account", selection: $selectedAccount) {
                        ForEach(model.Accounts, id: \.self) { account in
                            Button(
                                action: {
                                    self.selectedAccount = account
                                },
                                label: {
                                    Text(account.rawValue)
                                })
                        }
                    }.pickerStyle(SegmentedPickerStyle())

                }
            }
        }.environmentObject(AccountProcessor())
    }
}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView()
    }
}
