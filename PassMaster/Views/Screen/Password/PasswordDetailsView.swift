//
//  DetailsView.swift
//  PassMaster
//
//  Created by aleuts on 27/02/2021.
//

import SwiftUI

struct PasswordDetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var model1: AccountStore
    //@ObservedObject private var model = DetailsViewModel()
    @Binding var selection: PasswordModel
    @State private var canShowEditView = false
    @State private var canShowRecoverButton = false
    @State private var isShowingCopyAlert = false
    @State private var isShowingRecoverAlert = false
    private let itemName: String = AccountType.Password.rawValue

    
    var body: some View {
        NavigationView {
            Form{
                PasswordDetailsForm(selection: selection)
//                Section(header: Text("Login Information")) {
//                    //Text(selection.name)
//                    Text(selection.userName)
//                    HStack {
//                        Text(selection.password)
//                            .blur(radius: model.GetTextBlurRadius())
//                        Spacer()
//                        Button(
//                            action: {
//                                model.isBlurred.toggle()
//                            },
//                            label: {
//                                Text(model.GetTextBlurOptions())
//                        })
//                    }
//                    Text(selection.uRL ?? "")
//                }
//
//                Section(header: Text("Notes")) {
//                    Text(selection.notes ?? "")
//                }
                
                if !canShowRecoverButton {
                    CopyButton(isShowingCopyAlert: $isShowingCopyAlert, accountName: selection.name, accountSecret: selection.password, itemName: itemName)
                }
                
//                Section() {
//                    Button("Copy Password") {
//                        UIPasteboard.general.string = selection.password
//                        self.isShowingCopyAlert = true
//                    }.frame(
//                        minWidth: 0,
//                        maxWidth: .infinity,
//                        alignment: .center)
//                    .foregroundColor(Color.green)
//                    .font(Font.headline.weight(.bold))
//                    .alert(isPresented: $isShowingCopyAlert) {
//                        Alert(
//                            title: Text("Copy \(selection.name)'s Password"),
//                            message: Text("Password copied \n\(selection.password)"),
//                            dismissButton: .default(Text("OK")))
//                    }
//                }
                
                if canShowRecoverButton {
                    RestoreAccountButton(canShowRecoverButton: $canShowRecoverButton, isShowingRecoverAlert: $isShowingRecoverAlert, accountName: selection.name, function: {
                        model1.RestorePassword(account: selection)
                    })
//                    Section() {
//                        Button("Restore Account") {
//                            self.isShowingRecoverAlert = true
//                        }.disabled(!canShowRecoverButton)
//                        //.opacity(canShowRecoverButton ? 1 : 0)
//                        .frame(
//                            minWidth: 0,
//                            maxWidth: .infinity,
//                            alignment: .center)
//                        .foregroundColor(Color.orange)
//                        .font(Font.headline.weight(.bold))
//                        .alert(isPresented: $isShowingRecoverAlert) {
//                            Alert(
//                                title: Text("Recover \(selection.name)"),
//                                message: Text("Confirm \(selection.name) recovery"),
//                                primaryButton: .destructive(Text("Restore")) {
//                                    model1.RestorePassword(account: selection)
//                                    //model.RemovePassword(id: selection.id)
//                                    presentationMode.wrappedValue.dismiss()
//                                },
//                                secondaryButton: .cancel())
//                        }
//                    }
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
//                    Button("Delete Account") {
//                        self.isShowingAlert = true
//                    }.frame(
//                        minWidth: 0,
//                        maxWidth: .infinity,
//                        alignment: .center)
//                    .alert(isPresented: $isShowingAlert) {
//                        Alert(
//                            title: Text("Delete \(selection.name)"),
//                            message: Text("Confirm \(selection.name) removal"),
//                            primaryButton: .destructive(Text("Delete")) {
//                                NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: "AccountRemoved")))
//                                model.RemovePassword(id: selection.id)
//                                presentationMode.wrappedValue.dismiss()
//                            },
//                            secondaryButton: .cancel())
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
