//
//  PasswordDetailerView.swift
//  PassMaster
//
//  Created by aleuts on 16/03/2021.
//

import SwiftUI

struct PasswordDetailsForm: View {
    @StateObject private var model = BlurTextStore()
    @Binding var selection: PasswordModel
    
    var body: some View {
        Section(header: Text("Login Information")) {
            Text(selection.userName)
            HStack {
                Text(selection.password)
                    .blur(radius: model.GetTextBlurRadius())
                Spacer()
                BlurButton().environmentObject(model)
            }
            Text(selection.memorable ?? "")
            Text(selection.accountNo ?? "")
            Text(selection.uRL ?? "")
        }
        
        Section(header: Text("Notes")) {
            TextEditor(text: $selection.note.bound).disabled(true)
        }
    }
}

struct PasswordDetailerView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordDetailsForm(selection: .constant(PasswordModel.mock))
            .previewLayout(.sizeThatFits)
    }
}
