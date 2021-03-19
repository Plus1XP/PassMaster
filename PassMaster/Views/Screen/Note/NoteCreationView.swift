//
//  NoteCreationView.swift
//  PassMaster
//
//  Created by aleuts on 07/03/2021.
//

import SwiftUI

struct NoteCreationView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var model: AccountStore
    @State private var note: NoteModel = NoteModel.empty
    
    var body: some View {
        NavigationView {
            Form{
                NoteEditForm(account: $note)
            }.navigationBarTitle(Text(note.name))
            .navigationBarItems(
                leading:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        DismissButton()
                    },
                trailing:
                    Button(action: {
                        self.model.AddNote(account: note)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        SaveButton()
                    })
        }
    }
}

struct NoteCreationView_Previews: PreviewProvider {
    static var previews: some View {
        NoteCreationView()
            .environmentObject(AccountStore())
    }
}
