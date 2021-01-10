//
//  ContentView.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 19.12.2020.
//  Copyright © 2020 Halil Ibrahim Kasapoglu. All rights reserved.
//

import SwiftUI
import Firebase

var mainColor: Color = Color.green

struct ContentView: View {
    @EnvironmentObject var appState : AppState

    @State private var email: String = ""
    @State private var password: String = ""
    
    @State var isLoading = false
    @State var isSuccessful = false
    @State var showAlert = false
    @State var alertMessage = "Well Done"
    @State var activeUser: String = " none "
    
    func login(){
        self.isLoading = true
        print("hold on")
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            self.isLoading = false
            print("somehow wdone")
            if error != nil {
                self.alertMessage = error?.localizedDescription ?? ""
                self.showAlert = true
            } else {
                self.isSuccessful = true
                self.activeUser = self.email
                self.appState.state = "Main"
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    self.isSuccessful = false
                }
                print("well done")
            }
        }
    }
    
    var body: some View {
        
        NavigationView{
            
            VStack(alignment: .center) {
                
                Text("active user : " + self.activeUser).foregroundColor(mainColor)
                
                VStack(alignment: .leading){
                    Text("E Mail").font(.headline).foregroundColor(mainColor)
                    TextField("write your email", text: $email).background(mainColor).autocapitalization(.none)
                }.padding(16)
                
                
                VStack(alignment: .leading){
                    Text("Password").font(.headline).foregroundColor(mainColor)
                    TextField("write your password", text: $password).background(mainColor).autocapitalization(.none)
                    
                }.padding(16)
                
                Button(action: {
                    print("login button clicked")
                    self.login()
                    
                }, label:{
                    HStack(){
                        Text("LOGIN").foregroundColor(Color.white)
                            .padding()
                            .font(.headline)
                    }.frame(minWidth:0 ,maxWidth: .infinity)
                        .background(mainColor)
                        .cornerRadius(8.0).padding(16)
                }).alert(isPresented: $showAlert) {
                    Alert(title: Text("Login Failed"), message: Text("Wear sunscreen"), dismissButton: .default(Text("Got it!")))
                }
                
                
                NavigationLink(destination : RegisterView()){
                    Text("Register Instead").foregroundColor(mainColor)
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
