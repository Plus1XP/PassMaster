//
//  EnterDateButton.swift
//  PassMaster
//
//  Created by aleuts on 21/03/2021.
//

import SwiftUI

struct DateEditButton: View {
    @State var dateTitle: String
    @State var dateField: String
    
    @Binding var month: String
    @Binding var year: String
    @Binding var isSelectingDate: Bool
    
    var body: some View {
        Button(action: {
            self.isSelectingDate = true
        }) {
            if (self.month == "" && self.year == "") //|| (self.month == nil && self.year == nil)
            {
                Text(self.dateField)
                    .foregroundColor(Color(.tertiaryLabel))
            }
            else
            {
                Text("\(self.month) \(self.year)")
            }
        }.sheet(isPresented: $isSelectingDate, content: {
            DateEditForm(title: $dateTitle, month: $month, year: $year)
        })
    }
}

struct EnterDateButton_Previews: PreviewProvider {
    static var previews: some View {
        DateEditButton(dateTitle: "Card Start", dateField: "Start Date", month: .constant("Jan"), year: .constant("2015"), isSelectingDate: .constant(false))
    }
}
