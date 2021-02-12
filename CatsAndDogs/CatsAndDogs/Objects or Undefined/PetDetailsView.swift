//
//  PetDetailsView.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 11.02.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import SwiftUI

struct PetDetailsView: View {
    
    var pet: Pet
    
    var body: some View {
        
        Text(pet.json())
    }
}

struct PetDetailsView_Previews: PreviewProvider {
    static var pets = ModelData().pets

    static var previews: some View {
        PetDetailsView(pet: pets[0])
    }
}
