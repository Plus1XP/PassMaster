//
//  CardView.swift
//  PassMaster
//
//  Created by aleuts on 05/03/2021.
//

import SwiftUI

struct CardView: View {
    
    @EnvironmentObject var model: AccountStore

    @State private var selectedCard: CardModel = CardModel.mock
    
    @State private var canShowDetailsView = false
    
    var body: some View {
        Form{
            Section(header: Text("Cards")){
                List(self.model.Cards, id: \.self) { selectedCard in
                    Button(
                        action: {
                            self.selectedCard = selectedCard
                            self.canShowDetailsView.toggle()
                        },
                        label: {
                            AccountListForm(id: selectedCard.id, mainHeader: selectedCard.name, subHeader: String(selectedCard.number.description.suffix(4)))
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
            .environmentObject(AccountStore())
    }
}
