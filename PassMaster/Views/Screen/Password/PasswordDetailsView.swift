//
//  DetailsView.swift
//  PassMaster
//
//  Created by aleuts on 27/02/2021.
//

import SwiftUI

struct PasswordDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var model: AccountStore
    @Binding var selection: PasswordModel
    @State private var canShowEditView = false
    @State private var canShowRecoverButton = false
    @State private var isShowingCopyAlert = false
    @State private var isShowingRecoverAlert = false
    private let itemName: String = AccountType.Password.rawValue

    
    var body: some View {
        NavigationView {
            Form{
                PasswordDetailsForm(selection: $selection)
                
                if !canShowRecoverButton {
                    CopyButton(isShowingCopyAlert: $isShowingCopyAlert, accountName: selection.name, accountSecret: selection.password, itemName: itemName)
                }
                
                if canShowRecoverButton {
                    RestoreAccountButton(canShowRecoverButton: $canShowRecoverButton, isShowingRecoverAlert: $isShowingRecoverAlert, accountName: selection.name, function: {
                        model.RestorePassword(account: selection)
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
                            presentationMode.wrappedValue.dismiss()
                    }) {
                        DismissButton()
                },
                trailing:
                    Button(action: {
                            self.canShowEditView.toggle()
                    }) {
                        EditButton()
                            .sheet(isPresented: $canShowEditView) {
                                PasswordEditView(selection: $selection)
                            }
                    })
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordDetailsView(selection: .constant(PasswordModel.mock))
    }
}
