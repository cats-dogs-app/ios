//
//  Feeding.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 12.02.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import Foundation


struct Feeding: Hashable,Codable {
    
    var id: Int
    var petId: Int
    var feedId : Int
    var amount : Int
    var dateString : String
    
    init(id: Int , petId: Int , feedId : Int , amount : Int , dateString : String) {
        self.id = id
        self.petId = petId
        self.feedId = feedId
        self.amount = amount
        self.dateString = dateString
    }
    
/*
    func getDate(dateStr : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let createdDate = dateFormatter.dateFromString(date)
        return createdDate
    }*/
    
    func json() -> String{
        let jsonStr : String = """
        {\
        \"id\":\(self.id),\
        \"petId\":\(self.petId),\
        \"feedId\":\(self.feedId),\
        \"amount\":\(self.amount),\
        \"dateString\":\"\(self.dateString)\"\
        }
        """;
        print(jsonStr);
        return jsonStr;
    }
    
}
