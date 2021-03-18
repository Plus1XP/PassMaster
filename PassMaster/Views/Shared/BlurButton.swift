//
//  BlurButton.swift
//  PassMaster
//
//  Created by aleuts on 18/03/2021.
//

import SwiftUI

struct BlurButton: View {
    @EnvironmentObject private var model:  BlurTextStore
    
    var body: some View {
        Button(
            action: {
                model.isBlurred.toggle()
            },
            label: {
                Text(model.GetTextBlurOptions())
            })
    }
}

struct BlurButton_Previews: PreviewProvider {
    static var previews: some View {
        BlurButton()
    }
}
