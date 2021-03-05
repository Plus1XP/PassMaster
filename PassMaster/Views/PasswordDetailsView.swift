//
//  DetailsView.swift
//  PassMaster
//
//  Created by aleuts on 27/02/2021.
//

import SwiftUI

struct PasswordDetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject private var model = DetailsViewModel()
    
    @Binding var selection: PasswordModel
    
    @State private var isShowingAlert = false
    
    var body: some View {
        NavigationView {
            Form{
                
                Section(header: Text("Login Information")) {
                    HStack{
                        Text("Account Name:")
                        Text(selection.name)
                    }
                    //Text(selection.name)
                    Text(selection.userName)
                    HStack {
                        Text(selection.password)
                            .blur(radius: model.GetTextBlurRadius())
                        Spacer()
                        Button(
                            action: {
                                model.isBlurred.toggle()
                            },
                            label: {
                                Text(model.GetTextBlurOptions())
                        })
                    }
                    Text(selection.uRL ?? "")
                }
                
                Section(header: Text("Notes")) {
                    Text(selection.notes ?? "")
                }
                
                Section() {
                    Button("Copy Password") {
                        UIPasteboard.general.string = selection.password
                        self.isShowingAlert = true
                    }.frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        alignment: .center)
                    .alert(isPresented: $isShowingAlert) {
                        Alert(
                            title: Text("Copy \(selection.name)'s Password"),
                            message: Text("Password copied \n\(selection.password)"),
                            dismissButton: .default(Text("OK")))
                    }
                }
                
            }.navigationBarTitle(Text(selection.name))
             .navigationBarItems(
                leading:
                    Button(action: {
                            presentationMode.wrappedValue.dismiss() }) {
                    Label("Dismiss", systemImage: "trash")
                },
                trailing:
                    Button(action: {}) {
                    Label("Edit", systemImage: "pencil")
                })
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordDetailsView(selection: .constant(PasswordModel(id: 1, AccountType: AccountType.Password, name: "Yandex", userName: "Sergi", password: "M0th3rl4nd!", uRL: "www.yandex.com", notes: "In Russia password saves you!")))
    }
}
