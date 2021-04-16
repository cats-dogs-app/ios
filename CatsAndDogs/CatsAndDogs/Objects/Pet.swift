//
//  Dog.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 8.02.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import Foundation
import SwiftUI

struct Pet: Hashable,Codable {
    var id: Int
    var type: String
    var name: String
    var weight: Int
    var gender : String
    var age : Int
    
    init() {
        self.id = 0
        self.type = "dog"
        self.name = "havhav"
        self.weight = 0
        self.gender = "male"
        self.age = 0
    }
    init(id: Int , type: String , name : String , weight : Int , gender: String , age : Int) {
        self.id = id
        self.type = type
        self.name = name
        self.weight = weight
        self.gender = gender
        self.age = age
    }
    
    func json() -> String{
        let jsonStr : String = "{\"id\":\(self.id),\"type\":\"\(self.type)\",\"name\":\"\(self.name)\",\"weight\":\(self.weight),\"gender\":\"\(self.gender)\",\"age\":\(self.age)}";
        print(jsonStr);
        return jsonStr;
    }
    /*
     /// implement it later
     private var imageName : String
    var image: Image {
        Image(imageName)
    }*/
}

