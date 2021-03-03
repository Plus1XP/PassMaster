//
//  SelectionView.swift
//  PassMaster
//
//  Created by aleuts on 27/02/2021.
//

import SwiftUI

struct SelectionView: View {
    
    @StateObject private var model = AccountProcessor()
    
    @State private var selectedLogin: PasswordModel = PasswordModel(id: 0, name: "Example", userName: "JT@Example.com", password: "M0th3rl4nd!", uRL: "www.example.com", notes: "In Russia password saves you!")
    
    @State private var selectedCard: CardModel = CardModel(id: 0, name: "Example", number: 4090123456789090, start: "1 JAN", end: "31 DEC", cvv: 321, note: "Petty Cash")
    
    @State private var selectedNote: NoteModel = NoteModel(id: 0, title: "Example", body: "Example Text")
    
    @State private var canShowDetailsView = false
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Logins & Passwords")){
                    
                    List(model.Passwords, id: \.self) { selectedLogin in
                        Button(action: {
                            self.selectedLogin = selectedLogin
                            self.canShowDetailsView.toggle()
                        }, label: {
                            Text(selectedLogin.name)
                        }).sheet(isPresented: $canShowDetailsView) {
                            PasswordDetailsView(selection: $selectedLogin)
                        }
                    }
                }
                Section(header: Text("Cards")){
                    
                    List(model.Cards, id: \.self) { selectedCard in
                        Button(action: {
                            self.selectedCard = selectedCard
                            self.canShowDetailsView.toggle()
                        }, label: {
                            Text(selectedCard.name)
                        }).sheet(isPresented: $canShowDetailsView) {
                            CardDetailsView(selection: $selectedCard)
                        }
                    }
                }
                Section(header: Text("Notes")){
                    
                    List(model.Notes, id: \.self) { selectedNote in
                        Button(action: {
                            self.selectedNote = selectedNote
                            self.canShowDetailsView.toggle()
                        }, label: {
                            Text(selectedNote.title)
                        }).sheet(isPresented: $canShowDetailsView) {
                            NoteDetailsView(selection: $selectedNote)
                        }
                    }
                }
            }.navigationBarTitle(Text("PassMaster"))
            
/*
            Form{
                Section{
                    Picker("Select a login", selection: $selectedLogin) {
                        ForEach(model.Passwords, id: \.self) { password in
                            Button(action: {
                                self.selectedLogin = password
                                self.canShowDetailsView.toggle()
                            }, label: {
                                Text(password.name)
                            }).sheet(isPresented: $canShowDetailsView) {
                                DetailsView(selection: $selectedLogin)
                            }
                        }
                    }
                }
                Section{
                    Picker("Select a card", selection: $selectedCard) {
                        ForEach(model.Cards, id: \.self) { card in
                            Button(action: {
                                self.selectedCard = card
                                self.canShowDetailsView.toggle()
                            }, label: {
                                Text(card.name)
                            }).sheet(isPresented: $canShowDetailsView) {
                                //DetailsView(selection: $selectedCard)
                            }
                        }
                    }
                }
                Section{
                    Picker("Select a note", selection: $selectedNote) {
                        ForEach(model.Notes, id: \.self) { note in
                            Button(action: {
                                self.selectedNote = note
                                self.canShowDetailsView.toggle()
                            }, label: {
                                Text(note.title)
                            }).sheet(isPresented: $canShowDetailsView) {
                                //DetailsView(selection: $selectedNote)
                            }
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
