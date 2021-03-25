//
//  EditButtonView.swift
//  PassMaster
//
//  Created by aleuts on 16/03/2021.
//

import SwiftUI

struct EditButton: View {
    @Binding var canShowEditView: Bool
    
    var body: some View {
        Button(
            action: {
                self.canShowEditView.toggle()
            },
            label: {
                Label("Edit", systemImage: "pencil")
            })
    }
}

struct EditButtonView_Previews: PreviewProvider {
    static var previews: some View {
        EditButton(canShowEditView: .constant(false))
            .previewLayout(.sizeThatFits)
        
    }
}
