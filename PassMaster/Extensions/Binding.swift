//
//  Binding.swift
//  PassMaster
//
//  Created by aleuts on 07/03/2021.
//

import Foundation

extension Optional where Wrapped == String {
    private var _bound: String? {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
    public var bound: String {
        get {
            return _bound ?? ""
        }
        set {
            _bound = newValue.isEmpty ? nil : newValue
        }
    }
}
