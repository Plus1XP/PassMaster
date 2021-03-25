//
//  NoteEditView.swift
//  PassMaster
//
//  Created by aleuts on 07/03/2021.
//

import SwiftUI

struct NoteEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var noteStore: NoteStore
    @Binding var selection: NoteModel
    @State var isShowingAlert = false
    
    var body: some View {
        NavigationView {
            Form{
                NoteEditForm(account: $selection)
                
                Section() {
                    DeleteAccountButton(isShowingAlert: $isShowingAlert, accountName: selection.name, function: {
                        noteStore.RemoveNote(id: selection.id)
                    })
                }
            }.navigationBarTitle(Text(selection.name))
            .navigationBarItems(
                leading:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        DismissLabel()
                    },
                trailing:
                    Button(action: {
                        self.noteStore.EditNote(modified: selection)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        SaveLabel()
                    })
        }
    }
}

struct NoteEditView_Previews: PreviewProvider {
    static var previews: some View {
        NoteEditView(selection: .constant(NoteModel.mock))
            .environmentObject(AccountStore())
    }
}
