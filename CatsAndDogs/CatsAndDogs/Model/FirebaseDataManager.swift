//
//  FirebaseDataManager.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 8.03.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FirebaseDataManager: NSObject {
    
    var ref: DatabaseReference!
    
    static var manager: FirebaseDataManager = {
        return FirebaseDataManager()
    }()
    
    override init() {
        ref = Database.database().reference()
    }
    
    func saveData(head: String , jsonStr : String , id : Int) {
        
        guard let user : User = Auth.auth().currentUser else {
            print("no current user sorry")
            return
        }
        
        ref.child("users").child(user.uid).child(head).child("\(id)").setValue(jsonStr);
        
        let jsonData = parseJson(json: jsonStr)
        for data in jsonData{
            var key = data.0
            var value = data.1
            if key.first == "\"" && key.last == "\""{
                key.removeLast()
                key.removeFirst()
            }
            if value.first == "\"" && value.last == "\""{
                value.removeLast()
                value.removeFirst()
            }
            ref.child("users").child(user.uid).child(head).child("\(id)").child(key).setValue(value)
        }
        
        print("save was a success")
    }
    
    func readData(){
        // maybe later
    }
    
    func parseJson(json : String) -> [(String,String)]{
        var jsonString = json
        jsonString.removeFirst()
        jsonString.removeLast()
        let subStr = jsonString.split(separator: ",")
        var result = [] as [(String,String)]
        for item in subStr{
            
            let data = item.split(separator: ":", maxSplits: 1)
            result.append((String(data[0]) , String(data[1])))
        }
        return result
    }
    
    func jsonizer(data : Dictionary<String , String>) -> String{
        var json = "{"
        for item in data{
            
            var keyStr = ""
            var valueStr = ""
            if (self.isInt(str:item.key)){
                keyStr = item.key
            }else {
                keyStr = "\""+item.key+"\""
            }
            
            if (self.isInt(str:item.value)){
                valueStr = item.value
            }else {
                valueStr = "\""+item.value+"\""
            }
            let str = keyStr + ":" + valueStr + ","
            json += str
        }
        json.removeLast()
        json.append("}")
        return json
    }
    
    func isInt(str:String) -> Bool{
        return Int(str) != nil
    }
    
    func fetchAll(){
        guard let user : User = Auth.auth().currentUser else {
            print("no current user sorry")
            return
        }
        


        ref.child("users").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
            print("=======================")
            print("==let the fetch begin==")
            print("=======================")
            let value = snapshot.value as? [String: Any]
            for item in value!.keys{
                self.loadFile(head: item)
            }
            print("=======================")
          // ...
          }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func loadFile(head: String){
        guard let user : User = Auth.auth().currentUser else {
            print("no current user sorry")
            return
        }
        
        var keys :[String] = []
        
        self.ref.child("users").child(user.uid).child(head).observeSingleEvent(of: .value) { (snapshot) in
            
            guard let value = snapshot.value as? [String : Any] else {
                print("bruh " + head)
                return
            }
            for i in value.keys{
                keys.append(i)
            }
            
            for key in keys {
                self.ref.child("users").child(user.uid).child(head).child(key).observeSingleEvent(of: .value) { (snapshot) in
                    
                    guard let value = snapshot.value as? [String : String] else {
                        print("oww bruh " + head + " - this is bad - " + key)
                        return
                    }
                    
                    print(self.jsonizer(data: value))
                }
            }
        }
        
        
    }
    
    
    
    
    
    
}
