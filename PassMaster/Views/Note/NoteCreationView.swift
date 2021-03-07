//
//  NoteCreationView.swift
//  PassMaster
//
//  Created by aleuts on 07/03/2021.
//

import SwiftUI

struct NoteCreationView: View {
    
    @EnvironmentObject private var model: AccountProcessor
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var noteBody = ""
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Enter New Account Information")) {
                    TextField("Title", text: $title)
                    TextField("Body", text: $noteBody)
                }
            }.navigationBarTitle(Text(title))
            .navigationBarItems(
                leading:
                    Button(action: {
                            presentationMode.wrappedValue.dismiss() }) {
                        Label("Disgard", systemImage: "trash")
                    },
                trailing:
                    Button(action: {
                        model.AddNote(title: title, body: noteBody)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Label("Save", systemImage: "sdcard")
                    })
        }
    }
}

struct NoteCreationView_Previews: PreviewProvider {
    static var previews: some View {
        NoteCreationView()
            .environmentObject(AccountProcessor())
    }
}
