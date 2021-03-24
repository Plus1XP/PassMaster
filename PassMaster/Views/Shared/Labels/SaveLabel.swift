//
//  SaveButtonView.swift
//  PassMaster
//
//  Created by aleuts on 16/03/2021.
//

import SwiftUI

struct SaveLabel: View {
    var body: some View {
        Label("Save", systemImage: "sdcard")
    }
}

struct SaveButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SaveLabel()
    }
}
