//
//  DetailsView.swift
//  PassMaster
//
//  Created by aleuts on 27/02/2021.
//

import SwiftUI

struct DetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var selection: AccountModel
    
    //@State private var name = "Gmail"
    //@State private var user = "email@Gmail.com"
    //@State private var pass = "MyP@55w0rd!"
    //@State private var url = "www.gmail.com"
    //@State private var notes = "Used for spam mail only! ;p"
    @State private var isShowingAlert = false
    
    @State private var isBlurred = true
    @State private var addBlur = 3.0
    @State private var removeBlur = 0.0
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Current Account Information")) {
                    Text(selection.name)
                    Text(selection.userName)
                    HStack {
                        Text(selection.password).blur(radius: CGFloat(isBlurred ? addBlur : removeBlur))
                        Button(action: {isBlurred.toggle()}, label: {
                            Text(isBlurred ? "Show" : "Hide")
                        })
                    }
                    Text(selection.uRL)
                }
                Section(header: Text("Notes")) {
                    Text(selection.notes)
                }
                Section() {
                    Button("Show Password") {
                        self.isShowingAlert = true
                    }.alert(isPresented: $isShowingAlert) {
                        Alert(title: Text("\(selection.name)'s Password"),
                              message: Text("\(selection.password)"),
                              dismissButton: .default(Text("OK")))
                    }
                }
            }.navigationBarTitle(Text(selection.name)).navigationBarItems(leading: Button("Dismiss") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: HStack(){
                Image(systemName: "pencil")
                Button("Edit") {
                    
                }
            }
        )}
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(selection: .constant(AccountModel(id: 1, name: "Yandex", userName: "Sergi", password: "M0th3rl4nd!", uRL: "www.yandex.com", notes: "In Russia password saves you!")))
    }
}
