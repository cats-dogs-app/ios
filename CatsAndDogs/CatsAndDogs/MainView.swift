//
//  MainView.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 9.01.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import SwiftUI
import Firebase

struct MainView: View {
    @EnvironmentObject var appState : AppState

    @State var status : String = ""
    
    func getStatus(){
        let user = Auth.auth().currentUser
        if (user != nil){
            let verified = (user?.isEmailVerified ?? false)
            self.status = (user?.email ?? " no email ")
            print(verified)
            if (verified){
                self.status += " verified"
            }else{
                self.status += " need verification"
            }
        }else {
            self.status = " no user "
        }
        
    }
    
    func logout(){
        
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        appState.state = "Auth"
    }
    
    var body: some View {
        
        VStack(alignment: .center) {
            Text("Hello, You are in the realm of cats and dogs!").foregroundColor(mainColor)
            Text("Its good to see you " + (Auth.auth().currentUser?.email ?? "!!! err: i dont know who u are !!!")).foregroundColor(mainColor)
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
            
            Text("Your Status").foregroundColor(mainColor)
            Text(self.status)
            
            Button(action: {
                print("get status clicked")
                self.getStatus()
                print(self.status)
            }, label:{
                HStack(){
                    Text("See my verification status").foregroundColor(Color.white)
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


