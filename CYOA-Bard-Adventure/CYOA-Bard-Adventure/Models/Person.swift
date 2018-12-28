//
//  Person.swift
//  CYOA-Bard-Adventure
//
//  Created by Austin Cole on 12/27/18.
//  Copyright © 2018 Austin Cole. All rights reserved.
//

import UIKit

struct Person {
    let name: String
    var healthPoints: Int
    var inventory: [InventoryItem]
}
struct InventoryItem {
    let name: String
    let image: UIImage
    var quantity: Int
}
