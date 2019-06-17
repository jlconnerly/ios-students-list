//
//  Student.swift
//  Students
//
//  Created by Andrew R Madsen on 8/5/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import Foundation

struct Student: Codable { //Codable means this struct or class can be encoded or decoded from a different file types
    var name: String
    var course: String
    
    var firstName: String {
        return String(name.split(separator: " ")[0]) //allows us to separate our name string by the space
    }
    
    var lastName: String {
        return String(name.split(separator: " ").last ?? "")
    }
}

