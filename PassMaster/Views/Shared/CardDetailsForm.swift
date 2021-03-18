//
//  CardDetailsForm.swift
//  PassMaster
//
//  Created by aleuts on 18/03/2021.
//

import SwiftUI

struct CardDetailsForm: View {
    @StateObject private var model = BlurTextStore()
    @State var selection: CardModel
    
    var body: some View {
        Section(header: Text("Card Information")) {
            Text(selection.name)
            Text(String(selection.number))
            HStack {
                Text(String(selection.cvv))
                    .blur(radius: model.GetTextBlurRadius())
                Spacer()
                BlurButton().environmentObject(model)
            }
            Text(String(selection.start ?? ""))
            Text(String(selection.end))
        }
        
        Section(header: Text("Notes")) {
            TextEditor(text: $selection.note.bound).disabled(true)
        }
    }
}

struct CardDetailsForm_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailsForm(selection: CardModel.mock)
            .previewLayout(.sizeThatFits)
    }
}
