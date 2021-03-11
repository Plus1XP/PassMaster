//
//  CardEditView.swift
//  PassMaster
//
//  Created by aleuts on 07/03/2021.
//

import SwiftUI

struct CardEditView: View {

    @EnvironmentObject var model: AccountProcessor
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var selection: CardModel
    
    @State var isShowingAlert = false
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Edit Account Information")) {
                    TextField("Account Name", text: $selection.name)
                    TextField("Card Number", value: $selection.number, formatter: NumberFormatter()).keyboardType(.numberPad)
                    TextField("Start Date", text: $selection.start.bound)
                    TextField("Expiry Date", text: $selection.end)
                    TextField("CVV", value: $selection.cvv, formatter: NumberFormatter()).keyboardType(.numberPad)
                    TextField("Notes", text: $selection.note.bound)
                }.foregroundColor(Color.white)
                
                Section() {
                    Button("Delete Account") {
                        self.isShowingAlert = true
                    }.frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        alignment: .center)
                    .alert(isPresented: $isShowingAlert) {
                        Alert(
                            title: Text("Delete \(selection.name)"),
                            message: Text("Confirm \(selection.name) removal"),
                            primaryButton: .destructive(Text("Delete")) {
                                model.RemoveCard(id: selection.id)
                                presentationMode.wrappedValue.dismiss()
                            },
                            secondaryButton: .cancel())
                    }
                }
            }.navigationBarTitle(Text(selection.name))
            .navigationBarItems(
                leading:
                    Button(action: {
                            presentationMode.wrappedValue.dismiss() }) {
                        Label("Disgard", systemImage: "trash")
                    },
                trailing:
                    Button(action: {
                        self.model.EditCard(id: selection.id, name: selection.name, number: selection.number, start: selection.start, end: selection.end, cvv: selection.cvv, notes: selection.note)
                        
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Label("Save", systemImage: "sdcard")
                    })
        }
    }
}

struct CardEditView_Previews: PreviewProvider {
    static var previews: some View {
        CardEditView(selection: .constant(CardModel(id: 0, AccountType: .Card, name: "example", number: 4040123456789090, start: "JAN 20", end: "DEC 23", cvv: 123, note: "Petty Cash")))
            .environmentObject(AccountProcessor())
    }
}
