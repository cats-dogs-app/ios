//
//  DogFormView.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 8.02.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import SwiftUI

struct PetFormView: View {
    
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var modelData : ModelData
    
    @State var typeFilter : String = "dog"
    @State var name: String = ""
    @State var weight: String = ""
    
/*    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }*/
    
    func addNewPet(){
        let w = Int(weight) ?? -1
        if (w == -1){
            print("weight cannot be converted to int")
            return
        }else{
            print(w)
            var newpetid = 1
            newpetid = (modelData.pets.last?.id ?? 0) + 1
            let newpet = Pet(id:newpetid , type: typeFilter , name:self.name, weight: w)
            print(newpet)
            modelData.pets.append(newpet)
            
            // json-izer
            var jsonStr : String = "["
            for pet in modelData.pets {
                jsonStr += pet.json() + ","
            }
            jsonStr.removeLast()
            jsonStr += "]"
            // json-izer
            
            print(modelData.pets)
            print(jsonStr)
            do {
                try FilesManager().save(fileNamed: "pets.json", data: Data(jsonStr.utf8))
            }catch{
                print(error)
            }
            
            
            self.presentation.wrappedValue.dismiss()
        }
        
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Spacer()
            
            
            VStack(alignment: .leading){
                Text("Add new \(typeFilter) !").font(.system(size: 48)).bold().foregroundColor(Color("cd_darkgrey")).padding(.bottom)
                
                Text("Name").font(.headline).foregroundColor(Color("cd_darkgrey"))
                HStack(){
                    TextField("name of your pet", text: $name).padding(16.0).background(Color("cd_lightgrey")).cornerRadius(8.0).autocapitalization(.none).font(.headline)
                }
            }.padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
            
            VStack(alignment: .leading){
                Text("Weight").font(.headline).foregroundColor(Color("cd_darkgrey"))
                HStack(){
                    TextField("weight of your pet", text: $weight).padding(16.0).background(Color("cd_lightgrey")).cornerRadius(8.0).autocapitalization(.none).font(.headline).keyboardType(.numberPad)
                }
                
            }.padding(EdgeInsets(top: 0, leading: 32, bottom: 16, trailing: 32))
            
            
            Button(action: {
                print("add new pet button clicked")
                self.addNewPet()
                
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

struct PetFormView_Previews: PreviewProvider {
    static var previews: some View {
        PetFormView().environmentObject(ModelData())
    }
}
