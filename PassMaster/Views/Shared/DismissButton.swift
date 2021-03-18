//
//  DismissButtonView.swift
//  PassMaster
//
//  Created by aleuts on 16/03/2021.
//

import SwiftUI

struct DismissButton: View {
    var body: some View {
        Label("Dismiss", systemImage: "trash")
    }
}

struct DismissButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DismissButton()
            .previewLayout(.sizeThatFits)
    }
}
