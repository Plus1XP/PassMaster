//
//  CardDetailsViewModel.swift
//  PassMaster
//
//  Created by aleuts on 03/03/2021.
//

import SwiftUI

struct CardDetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var model = DetailsViewModel()
    
    @Binding var selection: CardModel
    
    @State private var isShowingAlert = false
    
    var body: some View {
        NavigationView {
            Form{
                
                Section(header: Text("Card Information")) {
                    Text(selection.name)
                    Text(String(selection.number))
                    HStack {
                        Text(String(selection.cvv)).blur(radius: model.GetTextBlurRadius())
                        Spacer()
                        Button(action: {model.isBlurred.toggle()}, label: {
                            Text(model.GetTextBlurOptions())
                        })
                    }
                    Text(String(selection.start ?? ""))
                    Text(String(selection.end))
                }
                
                Section(header: Text("Notes")) {
                    Text(selection.note ?? "")
                }
                
                Section() {
                    Button("Copy Number") {
                        UIPasteboard.general.string = String(selection.number)
                        self.isShowingAlert = true
                    }.frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .alert(isPresented: $isShowingAlert) {
                        Alert(title: Text("Copy \(selection.name)'s Number"),
                              message: Text("Number copied \n\(selection.number)"),
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

struct CardDetailsViewModel_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailsView(selection: .constant(CardModel(id: 0, name: "Example", number: 0000000000000000, start: "01 JAN", end: "31 JAN", cvv: 101, note: "Example Account")))
    }
}
