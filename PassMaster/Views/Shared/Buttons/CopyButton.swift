//
//  CopyPasswordButtonView.swift
//  PassMaster
//
//  Created by aleuts on 16/03/2021.
//

import SwiftUI

struct CopyButton: View {
    @Binding var isShowingCopyAlert: Bool
    var accountName: String
    var accountSecret: String
    var itemName: String
    
    var body: some View {
        Section() {
            Button(
                action: {
                    UIPasteboard.general.string = accountSecret
                    self.isShowingCopyAlert.toggle()
                },
                label: {
                    Label("Copy \(itemName)", systemImage: "doc.on.doc")
                })
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    alignment: .center)
                .foregroundColor(Color.green)
                .font(Font.headline.weight(.bold))
                .alert(isPresented: $isShowingCopyAlert) {
                    Alert(
                        title: Text("Copy \(accountName)'s \(itemName)"),
                        message: Text("\(itemName) copied \n\(accountSecret)"),
                        dismissButton: .default(Text("OK")))
                }
        }
    }
}

struct CopyPasswordButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CopyButton(isShowingCopyAlert: .constant(false), accountName: "example", accountSecret: "Password1", itemName: "Password")
    }
}
