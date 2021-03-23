//
//  ClearButton.swift
//  PassMaster
//
//  Created by aleuts on 23/03/2021.
//

import SwiftUI

struct ClearButton: View {
    @Binding var canClearSelection: Bool
    
    var body: some View {
        Button(
            action: {
                self.canClearSelection.toggle()
            },
            label: {
                Label("Clear", systemImage: "xmark.circle")
            })
    }
}

struct ClearButton_Previews: PreviewProvider {
    static var previews: some View {
        ClearButton(canClearSelection: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
