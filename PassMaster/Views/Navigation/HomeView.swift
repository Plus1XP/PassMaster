//
//  SelectionView.swift
//  PassMaster
//
//  Created by aleuts on 27/02/2021.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var accountStore = AccountStore()
    @StateObject private var passwordStore = PasswordStore()
    @StateObject private var cardStore = CardStore()
    @StateObject private var noteStore = NoteStore()
    @State private var selectedAccount: AccountType = .Password
    @State private var canShowCreationView = false
    
    var body: some View {
        NavigationView {
            VStack {
                AccountSwitch(selectedAccount: $selectedAccount)
            }.navigationBarTitle(Text("PassMaster"))
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.canShowCreationView.toggle()
                                    }) {
                                        Label("Add", systemImage: "plus.circle")
                                    })
            .sheet(isPresented: $canShowCreationView) {
                CreateAccountSwitch(selectedAccount: $selectedAccount)
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HomeTab(selectedAccount: $selectedAccount)
                }
            }
        }
        .environmentObject(accountStore)
        .environmentObject(passwordStore)
        .environmentObject(cardStore)
        .environmentObject(noteStore)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
