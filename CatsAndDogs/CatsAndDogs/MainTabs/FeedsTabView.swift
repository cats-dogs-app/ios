//
//  FeedsTabView.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 14.02.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import SwiftUI

struct FeedsTabView: View {
    
    @EnvironmentObject var modelData : ModelData
    @State var newForm : Bool = false
    
    var body: some View {
        
        NavigationView{
            VStack(){
                
                NavigationLink(destination: FeedFormView().environmentObject(modelData), isActive: $newForm) {
                    EmptyView()
                }
                
                FeedListView().environmentObject(modelData)
                
                Button(action: {
                    self.newForm = true
                }, label: {
                    HStack(){
                        Text("New Feed").foregroundColor(Color.white)
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

struct FeedsTabView_Previews: PreviewProvider {
    static var previews: some View {
        FeedsTabView().environmentObject(ModelData())
    }
}
