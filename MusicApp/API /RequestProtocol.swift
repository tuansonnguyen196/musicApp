//
//  RequestProtocol.swift
//  MusicApp
//
//  Created by Nero on 7/30/20.
//  Copyright © 2020 Nero. All rights reserved.
//

import Foundation

protocol RequestProtocol {
    func isServerAlive(with token: String) -> Bool
    
    func getAmount(for item: String, result: @escaping (Decimal) -> ())
    
    func getAvailability(for item: String, result: @escaping (Int) -> ())
}

class MockAPI: RequestProtocol {
    
    let shared = MockAPI()
    
    func isServerAlive(with token: String) -> Bool {
        return true
    }
    
    func getAmount(for item: String, result: @escaping (Decimal) -> ()) {
        result(10.99)
        return
    }
    
    func getAvailability(for item: String, result: @escaping (Int) -> ()) {
        result(1550)
        return
    }
}
