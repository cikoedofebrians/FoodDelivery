//
//  FDObservable.swift
//  FoodDelivery
//
//  Created by Ciko Edo Febrian on 15/04/24.
//

import Foundation


class FDObservable<T> {
    private var listeners: [(T) -> Void] = []
    
    var value: T {
        didSet {
            listeners.forEach { $0(value) }
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: @escaping (T) -> Void) {
        listener(value)
        self.listeners.append(listener)
    }
}
