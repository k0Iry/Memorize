//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Iry Tu on 2021-03-19.
//

import Foundation

extension Array where Element : Identifiable {
    /// Get index where matching the first occurrence
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        
        return nil
    }
}
