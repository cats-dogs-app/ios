//
//  FeedingFormView.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 12.02.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import SwiftUI

struct FeedingFormView: View {
    
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var modelData : ModelData
    @State var pet: Pet = Pet()
    @State private var selectedFeed = 0
    @State private var amount = ""
    @State private var date = Date()
    
    func getDateStr(date : Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let createdDateStr = dateFormatter.string(from: date)
        return createdDateStr
    }
    
    func saveFeed(){
        let w = Int(amount) ?? -1
        
        print(date)
        
        if (w == -1){
            print("amount cannot be converted to int")
            return
        }else{
            print(w)
            var newfeedingId = 1
            newfeedingId = (modelData.feedings.last?.id ?? 0) + 1
            
            let newFeeding = Feeding(id: newfeedingId, petId: pet.id, feedId: modelData.feeds[selectedFeed].id, amount: w, dateString: getDateStr(date: date))
            print(newFeeding)
            modelData.feedings.append(newFeeding)
            
            // json-izer
            var jsonStr : String = "["
            for feeding in modelData.feedings {
                jsonStr += feeding.json() + ","
            }
            jsonStr.removeLast()
            jsonStr += "]"
            // json-izer
            
            print(modelData.feedings)
            print(jsonStr)
            do {
                try FilesManager().save(fileNamed: "feedings.json", data: Data(jsonStr.utf8))
                FirebaseDataManager.manager.saveData(head: "feedings", jsonStr: newFeeding.json(), id: newfeedingId)
            }catch{
                print(error)
            }
            
            
            self.presentation.wrappedValue.dismiss()
        }
    }
    
    var body: some View {
        VStack(){
            Text("You are about to feed the following pet")
            
            Form {
                Section {
                    Picker("Feed", selection: $selectedFeed) {
                        ForEach(0 ..< modelData.feeds.count) {
                            Text(modelData.feeds[$0].name)
                        }
                    }
                    TextField("Amount", text: $amount).keyboardType(.numberPad)
                    DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
                                 Text("Feed Time")
                             }
                }
                Section {
                    Button("Feed") {
                        self.saveFeed()
                    }
                }
                
            }
        }
    }
}

struct FeedingFormView_Previews: PreviewProvider {
    static var previews: some View {
        FeedingFormView()
    }
}
