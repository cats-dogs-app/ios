//
//  MainView.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 9.01.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import SwiftUI

struct MainView: View {
        
    
    func logout(){
        
        // Write logout here
        // So we can turn back to login section
        
        return
    }
    
    var body: some View {
        
        VStack(alignment: .center) {
            Text("Hello, You are in the realm of cats and dogs!").foregroundColor(mainColor)
            
            Button(action: {
                print("logout button clicked")
                self.logout()
            }, label:{
                HStack(){
                    Text("Logout").foregroundColor(Color.white)
                        .padding()
                        .font(.headline)
                }.frame(minWidth:0 ,maxWidth: .infinity)
                    .background(mainColor)
                    .cornerRadius(8.0).padding(16)
            })
                        
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


