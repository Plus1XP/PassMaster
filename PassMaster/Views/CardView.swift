//
//  CardView.swift
//  PassMaster
//
//  Created by aleuts on 05/03/2021.
//

import SwiftUI

struct CardView: View {
    
    @EnvironmentObject private var model: AccountProcessor

    @State private var selectedCard: CardModel = CardModel(id: 0, AccountType: AccountType.Card, name: "Example", number: 4090123456789090, start: "1 JAN", end: "31 DEC", cvv: 321, note: "Petty Cash")
    
    @State private var canShowDetailsView = false
    
    var body: some View {
        Form{
            Section(header: Text("Cards")){
                List(model.Cards, id: \.self) { selectedCard in
                    Button(
                        action: {
                            self.selectedCard = selectedCard
                            self.canShowDetailsView.toggle()
                        },
                        label: {
                            HStack {
                                Text("C")
                                    .frame(width: 50, height: 50)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .padding(10)
                                VStack(alignment: .leading) {
                                    Text(selectedCard.name)
                                        .foregroundColor(Color.white)
                                    Text(String(selectedCard.number))
                                        .foregroundColor(Color.white)
                                        .font(.footnote) }
                            }
                        }).sheet(isPresented: $canShowDetailsView) {
                            CardDetailsView(selection: $selectedCard)
                        }
                }
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
            .environmentObject(AccountProcessor())
    }
}
