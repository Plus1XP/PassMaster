//
//  DateEditForm.swift
//  PassMaster
//
//  Created by aleuts on 20/03/2021.
//

import SwiftUI

struct DateEditForm: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var title: String
    @Binding var month: String
    @Binding var year: String
    
    @State var selectedMonth: Int = 0
    @State var selectedYear: Int = 2015
    
    let monthSource: [String] = (DateFormatter().shortMonthSymbols)
    let yearSource: [Int] = Array(2015...2030)
    
//    let monthSymbols = Calendar.current.monthSymbols
//    let years = Array(Date().year..<Date().year+10)
    
    var body: some View {
        NavigationView {
            HStack {
                VStack {
                    Text("Month")
                    Picker("Select Month", selection: $selectedMonth) {
                        ForEach(0..<monthSource.count, id: \.self) {
                            Text(self.monthSource[$0])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: UIScreen.main.bounds.width/2)
                    .clipped()
                }
                VStack {
                    Text("Year")
                    Picker("Select Year", selection: $selectedYear) {
                        ForEach(yearSource, id: \.self) {
                            Text(String($0))
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: UIScreen.main.bounds.width/2)
                    .clipped()
                }
            }
            .onAppear(perform: {
                self.selectedMonth = monthSource.firstIndex(of: self.month) ?? selectedMonth
                self.selectedYear = Int(self.year) ?? selectedYear
            })
            .onDisappear(perform: {
                self.month = "\(DateFormatter().shortMonthSymbols[selectedMonth])"
                self.year = selectedYear.description
            })
            .navigationBarTitle(Text(title))
            .navigationBarItems(
                leading:
                    Button(action: {
                            presentationMode.wrappedValue.dismiss()
                    }) {
                        DismissButton()
                    })
        }
    }
}

struct DateEditForm_Previews: PreviewProvider {
    static var previews: some View {
        DateEditForm(title: .constant("Select Date"), month: .constant("Jan"), year: .constant("2015"))
            .previewLayout(.sizeThatFits)
    }
}
