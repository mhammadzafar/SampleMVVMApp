//
//  Utilities.swift
//  SampleMVVMApp
//
//  Created by Hammad Zafar on 05/09/2021.
//

class Observable <T> {
    var value : T? {
        didSet {
            listeners.forEach {
                $0!(value)
            }
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listeners: [((T?) -> Void)?] = []
    
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listeners.append(listener)
    }
}
