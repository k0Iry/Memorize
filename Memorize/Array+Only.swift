//
//  Array+Only.swift
//  Memorize
//
//  Created by Iry Tu on 2021-03-20.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
