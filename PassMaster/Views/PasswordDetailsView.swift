//
//  DetailsView.swift
//  PassMaster
//
//  Created by aleuts on 27/02/2021.
//

import SwiftUI

struct PasswordDetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var model = DetailsViewModel()
    
    @Binding var selection: PasswordModel
    
    @State private var isShowingAlert = false
    
    var body: some View {
        NavigationView {
            Form{
                
                Section(header: Text("Login Information")) {
                    Text(selection.name)
                    Text(selection.userName)
                    HStack {
                        Text(selection.password).blur(radius: model.GetTextBlurRadius())
                        Spacer()
                        Button(action: {model.isBlurred.toggle()}, label: {
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
                    }.frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .alert(isPresented: $isShowingAlert) {
                        Alert(title: Text("Copy \(selection.name)'s Password"),
                              message: Text("Password copied \n\(selection.password)"),
                              dismissButton: .default(Text("OK")))
                    }
                }
                
            }.navigationBarTitle(Text(selection.name)).navigationBarItems(leading: Button("Dismiss") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: HStack(){
                Image(systemName: "pencil")
                Button("Edit") {
                    
                }
            })
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordDetailsView(selection: .constant(PasswordModel(id: 1, name: "Yandex", userName: "Sergi", password: "M0th3rl4nd!", uRL: "www.yandex.com", notes: "In Russia password saves you!")))
    }
}
