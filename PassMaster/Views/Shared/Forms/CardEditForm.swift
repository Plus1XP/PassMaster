//
//  CardEditForm.swift
//  PassMaster
//
//  Created by aleuts on 18/03/2021.
//

import SwiftUI

struct CardEditForm: View {
    @Binding var account: CardModel

    var body: some View {
        Section(header: Text("Edit Card Information")) {
            Group {
                TextField("Account Name", text: $account.name)
                TextField("Card Number", text: $account.number).keyboardType(.numberPad)
                TextField("Start Date", text: $account.start.bound)
                TextField("Expiry Date", text: $account.end)
                TextField("CVV", text: $account.cvv).keyboardType(.numberPad)
            }
            .modifier(FormGroupStyle())
        }
        .modifier(FormSectionStyle())
        
        Section(header: Text("Edit Note")) {
            
            Group {
                TextEditor(text: $account.note.bound)
            }
            .modifier(FormGroupStyle())
        }
        .modifier(FormSectionStyle())
    }
}

struct CardEditForm_Previews: PreviewProvider {
    static var previews: some View {
        CardEditForm(account: .constant(CardModel.mock))
            .previewLayout(.sizeThatFits)
    }
}
