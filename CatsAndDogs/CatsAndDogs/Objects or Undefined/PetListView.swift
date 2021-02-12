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

    var body: some View {
        List(modelData.pets,id:\.id){ pet in
            NavigationLink(destination: PetDetailsView(pet: pet)) {
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
