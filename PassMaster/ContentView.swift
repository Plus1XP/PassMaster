//
//  ContentView.swift
//  PassMaster
//
//  Created by aleuts on 25/02/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var canShowSelectionView: Bool = false
    
    var body: some View {
        Button(action: {
            print("Button Pushed")
            self.canShowSelectionView = true
        }, label: {
            Text("Login")
        }).fullScreenCover(isPresented: self.$canShowSelectionView) {
            SelectionView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
