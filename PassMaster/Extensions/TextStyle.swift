//
//  SectionTextStyle.swift
//  PassMaster
//
//  Created by aleuts on 19/03/2021.
//

import SwiftUI

extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

struct FormGroupStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.body.weight(.regular))
            .foregroundColor(Color(.label))
    }
}

struct FormSectionStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .font(Font.body.weight(.medium))
            .foregroundColor(Color(.secondaryLabel))
    }
}
