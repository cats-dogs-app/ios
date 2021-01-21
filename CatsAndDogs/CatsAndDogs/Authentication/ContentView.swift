//
//  ContentView.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 19.12.2020.
//  Copyright © 2020 Halil Ibrahim Kasapoglu. All rights reserved.
//

import SwiftUI
import Firebase

let mainColor : Color = Color.green
let cd_lightgreen : Color = Color("cd_lightgreen")
let cd_darkgreen : Color = Color("cd_darkgreen")

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
            
            
            VStack() {
                
                VStack(alignment: .leading){
                    Text("E Mail").font(.headline).foregroundColor(mainColor)
                    HStack(){
                        TextField("Type your email", text: $email).background(Color.white).autocapitalization(.none).font(.headline).padding(16.0)
                    }.background(mainColor).cornerRadius(8.0)
                }.padding(16)
                                
                VStack(alignment: .leading){
                    Text("Password").font(.headline).foregroundColor(mainColor)
                    HStack(){
                        TextField("Type your password", text: $password).autocapitalization(.none).font(.headline).padding(16.0)
                    }.background(mainColor).cornerRadius(8.0)
                    
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
                    .background(cd_lightgreen)
                    .cornerRadius(8.0).padding(16)
                }).alert(isPresented: $showAlert) {
                    Alert(title: Text("Login Failed"), message: Text("Wear sunscreen"), dismissButton: .default(Text("Got it!")))
                }
                
                VStack(alignment : .trailing){
                    NavigationLink(destination : RegisterView()){
                        Text("Register").foregroundColor(mainColor).background(cd_darkgreen)
                    }
                }
                
            }//Vstack
        }.background(LinearGradient(gradient: .init(colors: [cd_lightgreen,cd_darkgreen]), startPoint: .top, endPoint: .bottom))//NavigationView
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
