//
//  Data.swift
//  ToDo
//
//  Created by Dominique Strachan on 7/25/23.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
