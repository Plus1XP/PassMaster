//
//  SelectionView.swift
//  PassMaster
//
//  Created by aleuts on 27/02/2021.
//

import SwiftUI

struct SelectionView: View {
    
    @StateObject private var model = AccountProcessor()
    
    @State private var selectedLogin: PasswordModel = PasswordModel(id: 0, AccountType: AccountType.Password, name: "Example", userName: "JT@Example.com", password: "M0th3rl4nd!", uRL: "www.example.com", notes: "In Russia password saves you!")
    
    @State private var selectedCard: CardModel = CardModel(id: 0, AccountType: AccountType.Card, name: "Example", number: 4090123456789090, start: "1 JAN", end: "31 DEC", cvv: 321, note: "Petty Cash")
    
    @State private var selectedNote: NoteModel = NoteModel(id: 0, AccountType: AccountType.Note, title: "Example", body: "Example Text")
    
    @State private var selectedAccount: AccountType = AccountType.Password
    
    @State private var canShowDetailsView = false
    
    @State private var canShowCreationView = false
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Logins & Passwords")){
                    List(model.Passwords, id: \.self) { selectedLogin in
                        Button(
                            action: {
                                self.selectedLogin = selectedLogin
                                self.canShowDetailsView.toggle()
                            },
                            label: {
                                HStack {
                                    Text("L")
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
                Section(header: Text("Cards")){
                    List(model.Cards, id: \.self) { selectedCard in
                        Button(
                            action: {
                                self.selectedCard = selectedCard
                                self.canShowDetailsView.toggle()
                            },
                            label: {
                                HStack {
                                    Text("C")
                                        .frame(width: 50, height: 50)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .padding(10)
                                    VStack(alignment: .leading) {
                                        Text(selectedCard.name)
                                            .foregroundColor(Color.white)
                                        Text(String(selectedCard.number))
                                            .foregroundColor(Color.white)
                                            .font(.footnote) }
                                }
                            }).sheet(isPresented: $canShowDetailsView) {
                                CardDetailsView(selection: $selectedCard)
                            }
                    }
                }
                Section(header: Text("Notes")){
                    List(model.Notes, id: \.self) { selectedNote in
                        Button(
                            action: {
                                self.selectedNote = selectedNote
                                self.canShowDetailsView.toggle()
                            },
                            label: {
                                HStack {
                                    Text("N")
                                        .frame(width: 50, height: 50)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .padding(10)
                                    VStack(alignment: .leading) {
                                        Text(selectedNote.title)
                                            .foregroundColor(Color.white)
                                        Text(selectedNote.body)
                                            .foregroundColor(Color.white)
                                            .font(.footnote) }
                                }
                            }).sheet(isPresented: $canShowDetailsView) {
                                NoteDetailsView(selection: $selectedNote)
                            }
                    }
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
        }
    }
}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView()
    }
}
