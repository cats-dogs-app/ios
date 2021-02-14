//
//  PetDetailsView.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 11.02.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import SwiftUI

struct PetDetailsView: View {
    
    @EnvironmentObject var modelData : ModelData
    var pet: Pet
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            FeedingListView(pet: pet).environmentObject(modelData)
            
            Spacer()
            
            NavigationLink(
                destination: FeedFormView().environmentObject(modelData),
                label: {
                    Text("New Feed")
                })
            
            NavigationLink(
                destination: FeedingFormView(pet: pet).environmentObject(modelData),
                label: {
                    Text("Feed your pet")
                })

            Text(pet.json())

        }
        
    }
}

struct PetDetailsView_Previews: PreviewProvider {
    static var pets = ModelData().pets

    static var previews: some View {
        PetDetailsView(pet: pets[0] ).environmentObject(ModelData())
    }
}
