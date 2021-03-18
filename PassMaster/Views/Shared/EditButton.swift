//
//  EditButtonView.swift
//  PassMaster
//
//  Created by aleuts on 16/03/2021.
//

import SwiftUI

struct EditButton: View {
    var body: some View {
        Label("Edit", systemImage: "pencil")
    }
}

struct EditButtonView_Previews: PreviewProvider {
    static var previews: some View {
        EditButton()
    }
}
