//
//  NoteView.swift
//  PassMaster
//
//  Created by aleuts on 05/03/2021.
//

import SwiftUI

struct NoteView: View {
    
    @EnvironmentObject var model: AccountStore

    @State private var selectedNote: NoteModel = NoteModel.mock
    
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
                            AccountListForm(id: selectedNote.id, mainHeader: selectedNote.name, subHeader: String(selectedNote.note.prefix(10)))
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
            .environmentObject(AccountStore())
    }
}
