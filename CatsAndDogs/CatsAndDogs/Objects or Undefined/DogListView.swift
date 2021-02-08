//
//  DogListView.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 8.02.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import SwiftUI

struct DogListView: View{

    @EnvironmentObject var modelData: ModelData

    var body: some View {
        List(modelData.dogs,id:\.id){ dog in
            DogRow(dog: dog)
        }
    }
}

struct DogListView_Previews: PreviewProvider {
    static var previews: some View {
        DogListView().environmentObject(ModelData())
    }
}
