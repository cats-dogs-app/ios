//
//  DogRow.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 8.02.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import Foundation
import SwiftUI

struct DogRow: View {
    var dog: Dog

    var body: some View {
        HStack {
            Text("DOG \(dog.name) is \(dog.weight)kg")
        }
    }
}

struct DogRow_Previews: PreviewProvider {
    
    static var dogs = ModelData().dogs
    
    static var previews: some View {
        DogRow(dog: dogs[0])
    }
}
