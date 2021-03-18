//
//  NoteEditForm.swift
//  PassMaster
//
//  Created by aleuts on 18/03/2021.
//

import SwiftUI

struct NoteEditForm: View {
    @Binding var account: NoteModel
    
    var body: some View {
        Section(header: Text("Edit Note Information")) {
            Group {
                TextField("Title", text: $account.name)
            }
            .modifier(FormGroupStyle())
        }
        .modifier(FormSectionStyle())
        
        Section(header: Text("Edit Note")) {
            Group {
                TextEditor(text: $account.note)
            }
            .modifier(FormGroupStyle())
        }
        .modifier(FormSectionStyle())
    }
}
struct NoteEditForm_Previews: PreviewProvider {
    static var previews: some View {
        NoteEditForm(account: .constant(NoteModel.mock))
            .previewLayout(.sizeThatFits)
    }
}
