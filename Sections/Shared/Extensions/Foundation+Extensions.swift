//
//  Foundation+Extensions.swift
//
//  Created by Anoop M on 2021-04-24.
//

import Foundation

extension Array {
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}
