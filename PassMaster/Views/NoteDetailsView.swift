//
//  NotesDetailsView.swift
//  PassMaster
//
//  Created by aleuts on 03/03/2021.
//

import SwiftUI

struct NoteDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var model = DetailsViewModel()
    
    @Binding var selection: NoteModel
    
    @State private var isShowingAlert = false
    
    var body: some View {
        NavigationView {
            Form{
                
                Section(header: Text("Note Information")) {
                    Text(selection.title)
                    HStack {
                        Text(selection.body).blur(radius: model.GetTextBlurRadius())
                        Spacer()
                        Button(action: {model.isBlurred.toggle()}, label: {
                            Text(model.GetTextBlurOptions())
                        })
                    }
                }
                
                Section() {
                    Button("Copy Note") {
                        UIPasteboard.general.string = String(selection.body)
                        self.isShowingAlert = true
                    }.frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .alert(isPresented: $isShowingAlert) {
                        Alert(title: Text("Copy \(selection.title) Note"),
                              message: Text("Note copied \n\(selection.title)"),
                              dismissButton: .default(Text("OK")))
                    }
                }
                
            }.navigationBarTitle(Text(selection.title)).navigationBarItems(leading: Button("Dismiss") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: HStack(){
                Image(systemName: "pencil")
                Button("Edit") {
                    
                }
            })
        }
    }
}

struct NotesDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetailsView(selection: .constant(NoteModel(id: 1, title: "Example", body: "Example Text")))
    }
}
