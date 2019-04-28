//
//  Data.swift
//  HomeBudgetPL
//
//  Created by Marcin M on 25/04/2019.
//  Copyright © 2019 Marcin M. All rights reserved.
//

import Foundation
import RealmSwift

class Account : Object {
    @objc dynamic var balance = 0
    @objc dynamic var category = ""

    
    let transfers = List<Transfer>()
}

class Transfer : Object {
    @objc dynamic var expense = 0
    @objc dynamic var income = 0
    @objc dynamic var date = 0
    @objc dynamic var note = ""
}
