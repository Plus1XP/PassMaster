//
//  SelectionView.swift
//  PassMaster
//
//  Created by aleuts on 27/02/2021.
//

import SwiftUI

struct HomeView: View {
    @StateObject var model = AccountStore()
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
        }.environmentObject(model)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
