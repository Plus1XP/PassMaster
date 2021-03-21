//
//  CardDetailsViewModel.swift
//  PassMaster
//
//  Created by aleuts on 03/03/2021.
//

import SwiftUI

struct CardDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var cardStore: CardStore
    @Binding var selection: CardModel
    @State private var canShowEditView = false
    @State private var canShowRecoverButton = false
    @State private var isShowingCopyAlert = false
    @State private var isShowingRecoverAlert = false
    private let itemName: String = AccountType.Card.rawValue

    
    var body: some View {
        NavigationView {
            Form{
                CardDetailsForm(selection: $selection)
                
                if !canShowRecoverButton {
                    CopyButton(isShowingCopyAlert: $isShowingCopyAlert, accountName: selection.name, accountSecret: selection.number.description, itemName: itemName)
                }
                
                if canShowRecoverButton {
                    RestoreAccountButton(canShowRecoverButton: $canShowRecoverButton, isShowingRecoverAlert: $isShowingRecoverAlert, accountName: selection.name, function: {
                        cardStore.RestoreCard(account: selection)
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
                                CardEditView(selection: $selection)
                            }
                    })
        }
    }
}

struct CardDetailsViewModel_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailsView(selection: .constant(CardModel.mock))
    }
}
