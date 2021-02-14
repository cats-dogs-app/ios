//
//  FeedListView.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 14.02.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import SwiftUI

struct FeedListView: View {

    @EnvironmentObject var modelData: ModelData

    var body: some View {
        List(modelData.feeds,id:\.id){ feed in
            //NavigationLink(destination: PetDetailsView(pet: pet)) {
            Text("Feed : \(feed.name) with calorie : \(feed.calorie)")
            //}
        }
    }
}

struct FeedListView_Previews: PreviewProvider {
    static var previews: some View {
        FeedListView().environmentObject(ModelData())
    }
}
