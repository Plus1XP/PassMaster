//
//  CardEditForm.swift
//  PassMaster
//
//  Created by aleuts on 18/03/2021.
//

import SwiftUI

struct CardEditForm: View {
    @Binding var account: CardModel
    @State var isSelectingDate = false

    var body: some View {
        Section(header: Text("Edit Card Information")) {
            Group {
                TextField("Account Name", text: $account.name)
                TextField("Card Number", text: $account.number).keyboardType(.numberPad)
                DateEditButton(dateTitle: "Card Start", dateField: "Start Date", month: $account.startMonth.bound, year: $account.startYear.bound, isSelectingDate: $isSelectingDate)
                DateEditButton(dateTitle: "Card End", dateField: "Expiry Date", month: $account.endMonth, year: $account.endYear, isSelectingDate: $isSelectingDate)
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
