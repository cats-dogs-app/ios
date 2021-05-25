//
//  FeedingListView.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 14.02.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import SwiftUI

struct FeedingListView: View {
    @EnvironmentObject var modelData: ModelData
    @State var pet : Pet?
    
    func getList() -> [Feeding]{
        if (pet != nil){
            return filteredFeedings
        }
        else {
            return modelData.feedings
        }
    }
    
    var filteredFeedings : [Feeding] {
        modelData.feedings.filter{feeding in (pet?.id == feeding.petId)}
    }
    
    func getFeed(id : Int) -> Feed{
        for feed in modelData.feeds{
            if (feed.id == id){
                return feed
            }
        }
        return Feed(id: 0, name: "", calorie: 0)
    }
    
    var body: some View {
        List(filteredFeedings,id:\.id){ feeding in
          Spacer()
          Text(
            "\(feeding.amount * self.getFeed(id: feeding.feedId).calorie) cal. \(self.getFeed(id: feeding.feedId).name) in \(feeding.dateString.components(separatedBy: "T")[0])")
            //Text("You fed your \(pet?.type ?? "no type") \(pet?.name ?? "no name") on \(feeding.dateString) | feed_id:\(feeding.feedId) amount:\(feeding.amount)")
          Spacer()
        }
    }
}

struct FeedingListView_Previews: PreviewProvider {
    static var previews: some View {
        FeedingListView(pet: Pet()).environmentObject(ModelData())
    }
}
