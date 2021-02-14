//
//  FeedFormView.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 12.02.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import SwiftUI

struct FeedFormView: View {
    
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var modelData : ModelData
    
    @State var name: String = ""
    @State var calorie: String = ""
    
    func addNewFeed(){
        
        print(modelData.feeds)
        
        let w = Int(calorie) ?? -1
        if (w == -1){
            print("calorie cannot be converted to int")
            return
        }else{
            print(w)
            var newfeedid = 1
            newfeedid = (modelData.feeds.last?.id ?? 0) + 1
            let newfeed = Feed(id:newfeedid , name:self.name, calorie: w)
            print(newfeed)
            modelData.feeds.append(newfeed)
            
            // json-izer
            var jsonStr : String = "["
            for feed in modelData.feeds {
                jsonStr += feed.json() + ","
            }
            jsonStr.removeLast()
            jsonStr += "]"
            // json-izer
            
            print(modelData.feeds)
            print(jsonStr)
            do {
                try FilesManager().save(fileNamed: "feeds.json", data: Data(jsonStr.utf8))
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
                Text("Add new feed!").font(.system(size: 48)).bold().foregroundColor(Color("cd_darkgrey")).padding(.bottom)
                
                Text("Name").font(.headline).foregroundColor(Color("cd_darkgrey"))
                HStack(){
                    TextField("name of the feed", text: $name).padding(16.0).background(Color("cd_lightgrey")).cornerRadius(8.0).autocapitalization(.none).font(.headline)
                }
            }.padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
            
            VStack(alignment: .leading){
                Text("Calorie").font(.headline).foregroundColor(Color("cd_darkgrey"))
                HStack(){
                    TextField("calorie of the feed", text: $calorie).padding(16.0).background(Color("cd_lightgrey")).cornerRadius(8.0).autocapitalization(.none).font(.headline).keyboardType(.numberPad)
                }
                
            }.padding(EdgeInsets(top: 0, leading: 32, bottom: 16, trailing: 32))
            
            
            Button(action: {
                print("add new pet button clicked")
                self.addNewFeed()
                
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

struct FeedFormView_Previews: PreviewProvider {
    static var previews: some View {
        FeedFormView().environmentObject(ModelData())
    }
}
