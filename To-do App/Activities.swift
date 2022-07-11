//
//  Activitys.swift
//  To-do App
//
//  Created by Akel Barbosa on 11/07/22.
//

import Foundation


struct Task {
    var name: String
    var make: Bool
    
    init(name: String, make: Bool){
        self.name = name
        self.make = make
    }
    
}

struct Activities {
    var name: String
    var tasks =  [Task]()

    init (name: String) {
        self.name = name
    
    }
    
}


var listActivity = [Activities]()
