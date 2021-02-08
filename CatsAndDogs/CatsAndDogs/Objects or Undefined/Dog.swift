//
//  Dog.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 8.02.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import Foundation
import SwiftUI

struct Dog: Hashable,Codable {
    var id: Int
    var name: String
    var weight: Int
    
    init(id: Int , name : String , weight : Int) {
        self.id = id
        self.name = name
        self.weight = weight
    }
    /*
     /// implement it later
     private var imageName : String
    var image: Image {
        Image(imageName)
    }*/
}

