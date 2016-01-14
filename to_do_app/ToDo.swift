//
//  ToDo.swift
//  to_do_app
//
//  Created by as-131866 on 14.01.16.
//  Copyright (c) 2016 as-131866. All rights reserved.
//

import Foundation
import CoreData
@objc(ToDo)

class ToDo: NSManagedObject{

    @NSManaged var beschreibung: String
    @NSManaged var datum: String
    @NSManaged var toDo: String

}
