//
//  NoteView.swift
//  PassMaster
//
//  Created by aleuts on 05/03/2021.
//

import SwiftUI

struct NoteView: View {
    
    @EnvironmentObject var model: AccountProcessor

    @State private var selectedNote: NoteModel = NoteModel(id: 0, AccountType: AccountType.Note, title: "Example", body: "Example Text")    
    
    @State private var canShowDetailsView = false
    
    var body: some View {
        Form{
            Section(header: Text("Notes")){
                List(self.model.Notes, id: \.self) { selectedNote in
                    Button(
                        action: {
                            self.selectedNote = selectedNote
                            self.canShowDetailsView.toggle()
                        },
                        label: {
                            HStack {
                                Text(String(selectedNote.id))
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
        }
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
            .environmentObject(AccountProcessor())
    }
}
