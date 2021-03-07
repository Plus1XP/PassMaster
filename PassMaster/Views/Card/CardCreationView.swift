//
//  CardCreationView.swift
//  PassMaster
//
//  Created by aleuts on 07/03/2021.
//

import SwiftUI

struct CardCreationView: View {
    
    @EnvironmentObject var model: AccountProcessor
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var number = ""
    @State private var start = ""
    @State private var end = ""
    @State private var cvv = ""
    @State private var notes = ""
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Enter New Account Information")) {
                    TextField("Account Name", text: $name)
                    TextField("Card Number", text: $number).keyboardType(.numberPad)
                    TextField("Start Date", text: $start)
                    TextField("Expiry Date", text: $end)
                    TextField("CVV", text: $cvv).keyboardType(.numberPad)
                    TextField("Notes", text: $notes)
                }
            }.navigationBarTitle(Text(name))
            .navigationBarItems(
                leading:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss() }) {
                        Label("Disgard", systemImage: "trash")
                    },
                trailing:
                    Button(action: {
                        self.model.AddCard(name: name, number: number, start: start, end: end, cvv: cvv, notes: notes)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Label("Save", systemImage: "sdcard")
                    })
        }
    }
}

struct CardCreationView_Previews: PreviewProvider {
    static var previews: some View {
        CardCreationView()
            .environmentObject(AccountProcessor())
    }
}
