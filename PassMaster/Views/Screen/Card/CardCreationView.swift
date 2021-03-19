//
//  CardCreationView.swift
//  PassMaster
//
//  Created by aleuts on 07/03/2021.
//

import SwiftUI

struct CardCreationView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var model: AccountStore
    @State private var card: CardModel = CardModel.empty
    
    var body: some View {
        NavigationView {
            Form{
                CardEditForm(account: $card)
            }.navigationBarTitle(Text(card.name))
            .navigationBarItems(
                leading:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        DismissButton()
                    },
                trailing:
                    Button(action: {
                        self.model.AddCard(account: card)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        SaveButton()
                    })
        }
    }
}

struct CardCreationView_Previews: PreviewProvider {
    static var previews: some View {
        CardCreationView()
            .environmentObject(AccountStore())
    }
}
