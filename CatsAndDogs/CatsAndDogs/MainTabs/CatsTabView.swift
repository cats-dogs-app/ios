//
//  CatsTabView.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 8.02.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import SwiftUI

struct CatsTabView: View {
    
    @EnvironmentObject var modelData : ModelData
    @State var newForm : Bool = false
    
    var body: some View {
        
        NavigationView(){
            VStack(){
                
                NavigationLink(destination: PetFormView(typeFilter:"cat").environmentObject(modelData), isActive: $newForm) {
                    EmptyView()
                }
                PetListView(typeFilter:"cat").environmentObject(modelData)
                
                Spacer()
                
                if (modelData.pets.count == 0){
                    Text("Lets add your first cat!")
                }else {
                    Text("You have \(modelData.pets.count) pet")
                }
                
                Button(action: {
                    self.newForm = true
                }, label: {
                    HStack(){
                        Text("New Cat").foregroundColor(Color.white)
                            .padding()
                            .font(.headline)
                    }.frame(minWidth:0 ,maxWidth: .infinity)
                    .background(mainColor)
                    .cornerRadius(8.0).padding(EdgeInsets(top: 16, leading: 32, bottom: 32, trailing: 32))
                })
            }
      }.navigationBarTitle("Cats")

    }
    
}


struct CatsTabView_Previews: PreviewProvider {
    static var previews: some View {
        CatsTabView().environmentObject(ModelData())
    }
}
