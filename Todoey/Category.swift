//
//  Category.swift
//  Todoey
//
//  Created by Kameni Ngahdeu on 1/11/19.
//  Copyright © 2019 Kaydabi. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name = ""
    let items = List<Item>()
}
