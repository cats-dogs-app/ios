//
//  DogFormView.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 8.02.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import SwiftUI

struct DogFormView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @EnvironmentObject var modelData : ModelData

    @State var name: String = ""
    @State var weight: String = ""

    func addNewDog(){
        let w = Int(weight) ?? -1
        if (w == -1){
            print("weight cannot be converted to int")
            return
        }else{
            print(w)
            var newdogid = 1
            newdogid = (modelData.dogs.last?.id ?? 0) + 1
            let newdog = Dog(id:newdogid , name:self.name, weight: w)
            print(newdog)
            modelData.dogs.append(newdog)
            //modelData.dogs.append(newdog)
            self.presentation.wrappedValue.dismiss()
        }
        
    }
    
    var body: some View {
     
        VStack(alignment: .leading) {
            
            Spacer()
        
            
            VStack(alignment: .leading){
                Text("Add new dog !").font(.system(size: 48)).bold().foregroundColor(Color("cd_darkgrey")).padding(.bottom)
                
                Text("Name").font(.headline).foregroundColor(Color("cd_darkgrey"))
                HStack(){
                    TextField("name of your dog", text: $name).padding(16.0).background(Color("cd_lightgrey")).cornerRadius(8.0).autocapitalization(.none).font(.headline)
                }
            }.padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
            
            VStack(alignment: .leading){
                Text("Weight").font(.headline).foregroundColor(Color("cd_darkgrey"))
                HStack(){
                    TextField("weight of your dog", text: $weight).padding(16.0).background(Color("cd_lightgrey")).cornerRadius(8.0).autocapitalization(.none).font(.headline).keyboardType(.numberPad)
                }

            }.padding(EdgeInsets(top: 0, leading: 32, bottom: 16, trailing: 32))

            
            Button(action: {
                print("add new dog button clicked")
                self.addNewDog()
                
            }, label:{
                HStack(){
                    Text("CONFIRM").foregroundColor(Color.white)
                        .padding()
                        .font(.headline)
                }.frame(minWidth:0 ,maxWidth: .infinity)
                .background(mainColor)
                .cornerRadius(8.0).padding(EdgeInsets(top: 16, leading: 32, bottom: 64, trailing: 32))
            })
            
        }
        
    }
}

struct DogFormView_Previews: PreviewProvider {
    static var previews: some View {
        DogFormView().environmentObject(ModelData())
    }
}
