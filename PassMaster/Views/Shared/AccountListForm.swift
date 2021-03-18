//
//  AccountListView.swift
//  PassMaster
//
//  Created by aleuts on 16/03/2021.
//

import SwiftUI

struct AccountListForm: View {
    
    @State var id: Int
    @State var mainHeader: String
    @State var subHeader: String
    
    var body: some View {
        HStack {
            Text(String(self.id))
                .frame(width: 50, height: 50)
                .background(Color(.lightGray))
                .colorInvert()
                .border(Color(.label))
                .cornerRadius(10)
                .padding(10)
            VStack(alignment: .leading) {
                Text(self.mainHeader)
                Text(self.subHeader)
                    .lineLimit(1)
                    .font(.footnote)
            }
        }
        .foregroundColor(Color(.label))
    }
}

struct AccountListView_Previews: PreviewProvider {
    static var previews: some View {
        AccountListForm(id: 0, mainHeader: "example", subHeader: "My Example!")
            .previewLayout(.sizeThatFits)
    }
}
