//
//  DogsTabView.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 8.02.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import SwiftUI

struct DogsTabView: View {
    
    @State var newForm : Bool = false
    
    @StateObject private var modelData = ModelData()
/*    func addDog() {
        newForm = true
    }*/
    
    var body: some View {
        NavigationView(){
            VStack(){
                
                NavigationLink(destination: PetFormView().environmentObject(modelData), isActive: $newForm) {
                    EmptyView()
                }
                PetListView().environmentObject(modelData)
                
                Spacer()
                
                if (modelData.pets.count == 0){
                    Text("Lets add your first dog!")
                }else {
                    Text("You have \(modelData.pets.count) dog")
                }
                
                Button(action: {
                    self.newForm = true
                }, label: {
                    HStack(){
                        Text("New Dog").foregroundColor(Color.white)
                            .padding()
                            .font(.headline)
                    }.frame(minWidth:0 ,maxWidth: .infinity)
                    .background(mainColor)
                    .cornerRadius(8.0).padding(EdgeInsets(top: 16, leading: 32, bottom: 32, trailing: 32))
                })
            }
        }
    }
}

struct DogsTabView_Previews: PreviewProvider {
    static var previews: some View {
        DogsTabView()
    }
}
