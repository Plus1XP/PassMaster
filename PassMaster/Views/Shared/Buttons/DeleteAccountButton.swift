//
//  DeleteAccountButton.swift
//  PassMaster
//
//  Created by aleuts on 16/03/2021.
//

import SwiftUI

struct DeleteAccountButton: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var isShowingAlert: Bool
    var accountName: String
    var function: () -> Void
    
    var body: some View {
        Button(
            action: {
                self.isShowingAlert.toggle()
            },
            label: {
                Label("Delete Account", systemImage: "trash")
            })
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                alignment: .center)
            .foregroundColor(Color.red)
            .font(Font.headline.weight(.bold))
            .alert(isPresented: $isShowingAlert) {
                Alert(
                    title: Text("Delete \(accountName)"),
                    message: Text("Confirm \(accountName) removal"),
                    primaryButton: .destructive(Text("Delete")) {
                        NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: "AccountRemoved")))
                        self.function()
                        presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel())
            }
    }
}

struct DeleteAccountButton_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAccountButton(isShowingAlert: .constant(false), accountName: "example") { print("function passed") }
    }
}
