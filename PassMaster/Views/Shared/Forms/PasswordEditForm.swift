//
//  PasswordEditView.swift
//  PassMaster
//
//  Created by aleuts on 16/03/2021.
//

import SwiftUI

struct PasswordEditForm: View {
    @Binding var account: PasswordModel
    
    var body: some View {
        Section(header: Text("Edit Password Information")) {
            Group {
                TextField("Account Name", text: $account.name)
                TextField("Username", text: $account.userName).keyboardType(.emailAddress)
                TextField("Password", text: $account.password)
                TextField("Memorable Answer", text: $account.memorable.bound)
                TextField("Account No.", text: $account.accountNo.bound)
                TextField("URL", text: $account.uRL.bound).keyboardType(.URL)
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

struct PasswordEditorView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordEditForm(account: .constant(PasswordModel.mock))
            .previewLayout(.sizeThatFits)
    }
}
