//
//  NotesDetailsView.swift
//  PassMaster
//
//  Created by aleuts on 03/03/2021.
//

import SwiftUI

struct NoteDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var model = AccountStore()
    @Binding var selection: NoteModel
    @State private var canShowEditView = false
    @State private var canShowRecoverButton = false
    @State private var isShowingCopyAlert = false
    @State private var isShowingRecoverAlert = false
    private let itemName: String = AccountType.Note.rawValue
    
    var body: some View {
        NavigationView {
            Form{
                NoteDetailsForm(selection: selection)
                
                if !canShowRecoverButton {
                    CopyButton(isShowingCopyAlert: $isShowingCopyAlert, accountName: selection.name, accountSecret: selection.note, itemName: itemName)
                }
                
                if canShowRecoverButton {
                    RestoreAccountButton(canShowRecoverButton: $canShowRecoverButton, isShowingRecoverAlert: $isShowingRecoverAlert, accountName: selection.name, function: {
                        model.RestoreNote(account: selection)
                    })
                }
                
                
                
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "AccountRemoved"))) {
                _ in self.canShowRecoverButton = true
            }
            .navigationBarTitle(Text(selection.name))
             .navigationBarItems(
                leading:
                    Button(action: {
                            presentationMode.wrappedValue.dismiss() }) {
                        DismissButton()
                },
                trailing:
                    Button(action: {
                            self.canShowEditView.toggle()
                    }) {
                        EditButton()
                            .sheet(isPresented: $canShowEditView) {
                                NoteEditView(selection: $selection)
                            }
                    })
        }
    }
}

struct NotesDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetailsView(selection: .constant(NoteModel.mock))
    }
}
