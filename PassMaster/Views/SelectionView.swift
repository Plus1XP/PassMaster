//
//  SelectionView.swift
//  PassMaster
//
//  Created by aleuts on 27/02/2021.
//

import SwiftUI

struct SelectionView: View {
    
    @StateObject private var model = AccountProcessor()
    
    //let logins = ["Gmail", "Hotmail", "Yahoo"]
    @State private var selectedLogin: AccountModel = AccountModel(id: 1, name: "Example", userName: "JT@Example.com", password: "M0th3rl4nd!", uRL: "www.example.com", notes: "In Russia password saves you!")
    
    //let cards = ["Amex", "Visa", "MasterCard"]
    @State private var selectedCard = "Amex"
    
    let notes = ["Docter", "Council", "Shopping"]
    @State private var selectedNote = "Docter"
    
    @State private var canShowDetailsView = false
    
    var body: some View {
        NavigationView {
            /*
            List(model.superMarkets, id: \.self) { selectedLogin in
                Button(action: {
                    self.selectedLogin = selectedLogin
                    self.canShowDetailsView.toggle()
                }, label: {
                    Text(selectedLogin.name)
                }).sheet(isPresented: $canShowDetailsView) {
                    DetailsView(selection: $selectedLogin)
                }
            }.navigationBarTitle(Text("PassMaster"))
            */
            
            Form{
                Section{
                    Picker("Select a login", selection: $selectedLogin) {
                        ForEach(model.superMarkets, id: \.self) { AccountModel in
                            Button(action: {
                                self.selectedLogin = AccountModel
                                self.canShowDetailsView.toggle()
                            }, label: {
                                Text(AccountModel.name)
                            }).sheet(isPresented: $canShowDetailsView) {
                                DetailsView(selection: $selectedLogin)
                            }
                        }
                    }
                }
            }.navigationBarTitle(Text("PassMaster"))
            
            /*
            List(model.superMarkets, id: \.self) { selectedLogin in
                Button(selectedLogin.name) {
                    canShowDetailsView.toggle()
                }.sheet(isPresented: $canShowDetailsView) {
                    DetailsView(selection: $selectedLogin)
                }
                
            }.navigationBarTitle(Text("PassMaster"))
            */
            
            /*
            List(model.superMarkets, id: \.self) { selectedLogin in
                NavigationLink(destination: DetailsView(selection: $selectedLogin)) {
                    Text(selectedLogin.name)
                }
            }.navigationBarTitle(Text("PassMaster"))
            */
            
            /*
            Form{
                Section{
                    Picker("Select a login", selection: $selectedLogin) {
                        ForEach(model.superMarkets) { AccountModel in Button(AccountModel.name) {
                            canShowDetailsView.toggle()
                        }.sheet(isPresented: $canShowDetailsView) {
                            DetailsView(selection: $selectedLogin)
                        }
                        }
                    }
                }
                
                Section{
                    Picker("Select a card", selection: $selectedCard) {
                        ForEach(model.cards, id: \.self) {
                            Button($0) {
                            }
                        }
                    }
                }
                
                    Section{
                        Picker("Select a note", selection: $selectedNote) {
                            ForEach(0 ..< notes.count) {
                                Text(self.notes[$0])
                            }
                        }
                    }
                }.navigationBarTitle(Text("PassMaster"))
            */
            }
        }
    }
    
    struct SelectionView_Previews: PreviewProvider {
        static var previews: some View {
            SelectionView()
        }
    }
