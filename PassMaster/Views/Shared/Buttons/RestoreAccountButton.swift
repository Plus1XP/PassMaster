//
//  RestoreAccountButton.swift
//  PassMaster
//
//  Created by aleuts on 16/03/2021.
//

import SwiftUI

struct RestoreAccountButton: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var canShowRecoverButton: Bool
    @Binding var isShowingRecoverAlert: Bool
    var accountName: String
    var function: () -> Void
    
    var body: some View {
        
        Section() {
            Button(
                action: {
                    self.isShowingRecoverAlert.toggle()
                },
                label: {
                    Label("Restore Account", systemImage: "trash.slash")
                })
                .disabled(!canShowRecoverButton)
//                .opacity(canShowRecoverButton ? 1 : 0)
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    alignment: .center)
                .foregroundColor(Color.orange)
                .font(Font.headline.weight(.bold))
                .alert(isPresented: $isShowingRecoverAlert) {
                    Alert(
                        title: Text("Recover \(accountName)"),
                        message: Text("Confirm \(accountName) recovery"),
                        primaryButton: .destructive(Text("Restore")) {
                            self.function()
//                            model.RemovePassword(id: selection.id)
                            presentationMode.wrappedValue.dismiss()
                        },
                        secondaryButton: .cancel())
                }
        }
    }
}

struct RestoreAccountButton_Previews: PreviewProvider {
    static var previews: some View {
        RestoreAccountButton(canShowRecoverButton: .constant(false), isShowingRecoverAlert: .constant(false), accountName: "example") {}
    }
}
