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
    
    init(id: Int ,name : String , weight : Int) {
        self.id = id
        self.type = "dog"
        self.name = name
        self.weight = weight
    }
    
    func json() -> String{
        let jsonStr : String = "{\"id\":\(self.id),\"type\":\"\(self.type)\",\"name\":\"\(self.name)\",\"weight\":\(self.weight)}";
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

