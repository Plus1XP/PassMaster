//
//  NotesDetailsView.swift
//  PassMaster
//
//  Created by aleuts on 03/03/2021.
//

import SwiftUI

struct NoteDetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject private var model = DetailsViewModel()
    
    @Binding var selection: NoteModel
    
    @State private var canShowEditView = false
    
    @State private var isShowingAlert = false
    
    var body: some View {
        NavigationView {
            Form{
                
                Section(header: Text("Note Information")) {
                    Text(selection.title)
                    HStack {
                        TextEditor(text: $selection.body)
                            .blur(radius: model.GetTextBlurRadius())//.disabled(true)
                        Button(
                            action: {
                                model.isBlurred.toggle()
                        },
                            label: {
                                Text(model.GetTextBlurOptions())
                        })
                    }
                }
                
                Section() {
                    Button("Copy Note") {
                        UIPasteboard.general.string = String(selection.body)
                        self.isShowingAlert = true
                    }.frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        alignment: .center)
                     .alert(
                        isPresented: $isShowingAlert) {
                            Alert(
                                title: Text("Copy \(selection.title) Note"),
                                message: Text("Note copied \n\(selection.title)"),
                                dismissButton: .default(Text("OK")))
                    }
                }
                
            }.navigationBarTitle(Text(selection.title))
             .navigationBarItems(
                leading:
                    Button(action: {
                            presentationMode.wrappedValue.dismiss() }) {
                        Label("Dismiss", systemImage: "trash")
                },
                trailing:
                    Button(action: {
                            self.canShowEditView.toggle() }) {
                        Label("Edit", systemImage: "pencil")
                            .sheet(isPresented: $canShowEditView) {
                                NoteEditView(selection: $selection)
                            }
                    })
        }
    }
}

struct NotesDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetailsView(selection: .constant(NoteModel(id: 1, AccountType: AccountType.Note, title: "Example", body: "Example Text")))
    }
}
