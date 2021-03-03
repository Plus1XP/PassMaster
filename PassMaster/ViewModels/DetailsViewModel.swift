//
//  DetailsViewModel.swift
//  PassMaster
//
//  Created by aleuts on 03/03/2021.
//

import Foundation
import CoreGraphics

class DetailsViewModel: ObservableObject {
    
    @Published var isBlurred = true
    
    let addBlur = 3.0
    let removeBlur = 0.0
    
    func GetTextBlurOptions() -> String {
        return isBlurred ? "Show" : "Hide"
    }

    func GetTextBlurRadius() -> CGFloat {
        return CGFloat(isBlurred ? addBlur : removeBlur)
    }
}
