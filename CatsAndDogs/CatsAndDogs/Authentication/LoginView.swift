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

struct LoginView: View {
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
                
                // very dangerous approach i think
                FirebaseDataManager.manager.fetchAll()
                self.appState.state = "Main"
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    self.isSuccessful = false
                }
                print("well done")
            }
        }
    }

    
    var body: some View {
        
        VStack(alignment :.leading) {
            
            Spacer()
            
            VStack(alignment: .leading){
                Text("Welcome !").font(.system(size: 48)).bold().foregroundColor(Color("cd_darkgrey")).padding(.bottom)
                
                Text("E Mail").font(.headline).foregroundColor(Color("cd_darkgrey"))
                HStack(){
                    TextField("Type your email", text: $email).padding(16.0).background(Color("cd_lightgrey")).cornerRadius(8.0).autocapitalization(.none).font(.headline)
                }
            }.padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
            
            VStack(alignment: .leading){
                Text("Password").font(.headline).foregroundColor(Color("cd_darkgrey"))
                HStack(){
                    TextField("Type your password", text: $password).padding(16.0).background(Color("cd_lightgrey")).cornerRadius(8.0).autocapitalization(.none).font(.headline)
                }
                
            }.padding(EdgeInsets(top: 0, leading: 32, bottom: 16, trailing: 32))
            
            Button(action: {
                print("login button clicked")
                self.login()
                
            }, label: {
                HStack(){
                    Text("LOGIN").foregroundColor(Color.white)
                        .padding()
                        .font(.headline)
                }.frame(minWidth:0 ,maxWidth: .infinity)
                .background(mainColor)
                .cornerRadius(8.0).padding(EdgeInsets(top: 16, leading: 32, bottom: 64, trailing: 32))
            }).alert(isPresented: $showAlert) {
                Alert(title: Text("Login Failed"), message: Text("Wear sunscreen"), dismissButton: .default(Text("Got it!")))
            }
            
            HStack(){
                Text("Don't have an account ? ").foregroundColor(Color("cd_lightgreen"))
                
                NavigationLink (
                    destination: RegisterView(),
                    label: {
                        Text("Register").foregroundColor(Color("cd_darkgreen"))
                    })
            }.padding(EdgeInsets(top: 0, leading: 32, bottom: 32, trailing: 0))
            
        }.frame(
            minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading).edgesIgnoringSafeArea(.bottom)//Vstack
        
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
