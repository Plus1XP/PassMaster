//
//  NotesDetailsForm.swift
//  PassMaster
//
//  Created by aleuts on 18/03/2021.
//

import SwiftUI

struct NoteDetailsForm: View {
    @StateObject private var model = BlurTextStore()
    @Binding var selection: NoteModel
    
    var body: some View {
        Section(header: Text("Note")) {
            HStack {
                TextEditor(text: $selection.note).disabled(true)
                    .blur(radius: model.GetTextBlurRadius())
                BlurButton().environmentObject(model)
            }
        }
    }
}

struct NotesDetailsForm_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetailsForm(selection: .constant(NoteModel.mock))
            .previewLayout(.sizeThatFits)
    }
}
