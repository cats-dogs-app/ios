//
//  DogListView.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 8.02.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import SwiftUI

struct PetListView: View{

    @EnvironmentObject var modelData: ModelData
    @State var typeFilter : String?
    
    func getList() -> [Pet]{
        if (typeFilter != nil){
            return filteredPets
        }
        else {
            return modelData.pets
        }
    }
    
    var filteredPets : [Pet] {
        modelData.pets.filter{pet in (pet.type == typeFilter)}
    }
    
    var body: some View {
        List(getList(),id:\.id){ pet in
            NavigationLink(destination: PetDetailsView(pet: pet).environmentObject(modelData)) {
                PetListRow(pet: pet)
            }
        }
    }
}

struct PetListView_Previews: PreviewProvider {
    static var previews: some View {
        PetListView().environmentObject(ModelData())
    }
}
