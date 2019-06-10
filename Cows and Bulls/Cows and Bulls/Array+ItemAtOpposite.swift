//
//  Array+ItemAtOpposite.swift
//  Cows and Bulls
//
//  Created by Samantha Gatt on 6/9/19.
//  Copyright © 2019 Samantha Gatt. All rights reserved.
//

import Foundation

extension Array {
    func itemAt(opposite index: Int) -> Element {
        return self[count - 1 - index]
    }
}
