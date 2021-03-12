//
//  DogRow.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 8.02.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import Foundation
import SwiftUI

struct PetListRow: View {
    var pet: Pet

    var body: some View {
        HStack {
            Text("\(pet.type) \(pet.name) is \(pet.weight)kg")
        }
    }
}

struct PetListRow_Previews: PreviewProvider {
    
    //static var pets = ModelData().pets
    
    static var previews: some View {
        PetListRow(pet: Pet())
    }
}
