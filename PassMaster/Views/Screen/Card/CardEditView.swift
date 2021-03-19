//
//  CardEditView.swift
//  PassMaster
//
//  Created by aleuts on 07/03/2021.
//

import SwiftUI

struct CardEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var model: AccountStore
    @Binding var selection: CardModel
    @State var isShowingAlert = false
    
    var body: some View {
        NavigationView {
            Form{
                CardEditForm(account: $selection)
                
                Section() {
                    DeleteAccountButton(isShowingAlert: $isShowingAlert, accountName: selection.name, function: {
                        model.RemoveCard(id: selection.id)
                    })
                }
            }.navigationBarTitle(Text(selection.name))
            .navigationBarItems(
                leading:
                    Button(action: {
                            presentationMode.wrappedValue.dismiss()
                    }) {
                        DismissButton()
                    },
                trailing:
                    Button(action: {
                        self.model.EditCard(id: selection.id, name: selection.name, number: selection.number, start: selection.start, end: selection.end, cvv: selection.cvv, notes: selection.note)
                        
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        SaveButton()
                    })
        }
    }
}

struct CardEditView_Previews: PreviewProvider {
    static var previews: some View {
        CardEditView(selection: .constant(CardModel.mock))
            .environmentObject(AccountStore())
            //.colorScheme(.light)
    }
}
