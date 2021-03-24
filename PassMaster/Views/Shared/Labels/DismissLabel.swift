//
//  DismissButtonView.swift
//  PassMaster
//
//  Created by aleuts on 16/03/2021.
//

import SwiftUI

struct DismissLabel: View {
    var body: some View {
        Label("Dismiss", systemImage: "chevron.down.circle")
    }
}

struct DismissButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DismissLabel()
            .previewLayout(.sizeThatFits)
    }
}
