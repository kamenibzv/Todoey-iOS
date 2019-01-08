//
//  Item.swift
//  Todoey
//
//  Created by Kameni Ngahdeu on 1/8/19.
//  Copyright © 2019 Kaydabi. All rights reserved.
//

import Foundation

class Item {
    
    var title: String = ""
    var done: Bool = false
    
    init(toDoTitle: String) {
        title = toDoTitle
    }
    
}
