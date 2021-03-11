//
//  NoteEditView.swift
//  PassMaster
//
//  Created by aleuts on 07/03/2021.
//

import SwiftUI

struct NoteEditView: View {

    @EnvironmentObject var model: AccountProcessor
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var selection: NoteModel
    
    @State var isShowingAlert = false
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Edit Account Information")) {
                    TextField("Title", text: $selection.title)
                    TextField("Body", text: $selection.body)
                }.foregroundColor(Color.white)
                
                Section() {
                    Button("Delete Account") {
                        //model.RemovePassword(id: selection.id)
                        self.isShowingAlert = true
                    }.frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        alignment: .center)
                    .alert(isPresented: $isShowingAlert) {
                        Alert(
                            title: Text("Delete \(selection.title)"),
                            message: Text("Confirm \(selection.title) removal"),
                            primaryButton: .destructive(Text("Delete")) {
                                model.RemoveNote(id: selection.id)
                                presentationMode.wrappedValue.dismiss()
                            },
                            secondaryButton: .cancel())
                    }
                }
            }.navigationBarTitle(Text(selection.title))
            .navigationBarItems(
                leading:
                    Button(action: {
                            presentationMode.wrappedValue.dismiss() }) {
                        Label("Disgard", systemImage: "trash")
                    },
                trailing:
                    Button(action: {
                        self.model.EditNote(id: selection.id, title: selection.title, body: selection.body)
                        
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Label("Save", systemImage: "sdcard")
                    })
        }
    }
}

struct NoteEditView_Previews: PreviewProvider {
    static var previews: some View {
        NoteEditView(selection: .constant(NoteModel(id: 0, AccountType: .Note, title: "Example", body: "I am a note")))
            .environmentObject(AccountProcessor())
    }
}
