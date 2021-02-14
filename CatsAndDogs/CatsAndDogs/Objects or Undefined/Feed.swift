//
//  Feed.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 12.02.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import Foundation

struct Feed: Hashable,Codable {

    var id: Int
    //var type: String
    var name: String
    var calorie: Int
 
    init(id: Int ,name : String , calorie : Int) {
        self.id = id
        self.name = name
        self.calorie = calorie
    }
    
    func json() -> String{
        let jsonStr : String = "{\"id\":\(self.id),\"name\":\"\(self.name)\",\"calorie\":\(self.calorie)}";
        print(jsonStr);
        return jsonStr;
    }
    
}
