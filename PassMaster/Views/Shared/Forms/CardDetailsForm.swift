//
//  CardDetailsForm.swift
//  PassMaster
//
//  Created by aleuts on 18/03/2021.
//

import SwiftUI

struct CardDetailsForm: View {
    @StateObject private var model = BlurTextStore()
    @Binding var selection: CardModel
    
    var body: some View {
        Section(header: Text("Card Information")) {
            Text(String(selection.number))
            HStack {
                Text(String(selection.cvv))
                    .blur(radius: model.GetTextBlurRadius())
                Spacer()
                BlurButton().environmentObject(model)
            }
            Text(String("\(selection.startMonth.bound) \(selection.startYear.bound)"))
            Text(String("\(selection.endMonth) \(selection.endYear)"))
        }
        
        Section(header: Text("Notes")) {
            TextEditor(text: $selection.note.bound).disabled(true)
        }
    }
}

struct CardDetailsForm_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailsForm(selection: .constant(CardModel.mock))
            .previewLayout(.sizeThatFits)
    }
}
