//
//  RegisterView.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 9.01.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import SwiftUI
import Firebase


struct RegisterView: View {
    
    //@State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var password2: String = ""
    
    @State var isLoading = false
    @State var isSuccessful = false
    @State var showAlert = false
    @State var alertMessage:String = " none "
    @State var activeUser: String = " none "
    @State var registered = false
    func register(){
        
        // there may be a need to implement few more checks like if password1 == password2
        
        if (password != password2){
            self.alertMessage = "Unmatching passwords"
            self.showAlert = true
            return
        }
        
        
        self.isLoading = true
        print("hold on")
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            // ...
            self.isLoading = false
            if error != nil {
                self.alertMessage = error?.localizedDescription ?? ""
                self.showAlert = true
            } else {
                print("well done")
                
                self.isSuccessful = true
                self.activeUser = self.email
                self.verify()
                self.registered = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    self.isSuccessful = false
                }
            }
        }
    }
    
    func verify(){
        print("verifying : " + email)
        
        Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
            print(error ?? "No error go check your email")
        })
    }
    
    var body: some View {
        
        
        VStack(alignment: .leading) {
            
            Spacer()
            
            
                        
            VStack(alignment: .leading){
                /*Text("Register !").font(.system(size: 48)).bold().foregroundColor(Color("cd_darkgrey")).padding(.bottom)*/
                
                Text("E Mail").font(.headline).foregroundColor(Color("cd_darkgrey"))
                HStack(){
                    TextField("Type your email", text: $email).padding(16.0).background(Color("cd_lightgrey")).cornerRadius(8.0).autocapitalization(.none).font(.headline)
                }
            }.padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
            
            VStack(alignment: .leading){
                Text("Password").font(.headline).foregroundColor(Color("cd_darkgrey"))
                HStack(){
                    SecureField("Type your password", text: $password).padding(16.0).background(Color("cd_lightgrey")).cornerRadius(8.0).autocapitalization(.none).font(.headline)
                }
                
                Text("Confirm Password").font(.headline).foregroundColor(Color("cd_darkgrey")).padding(.top, 4)
                HStack(){
                    SecureField("Type your password", text: $password2).padding(16.0).background(Color("cd_lightgrey")).cornerRadius(8.0).autocapitalization(.none).font(.headline)
                }
                
            }.padding(EdgeInsets(top: 0, leading: 32, bottom: 16, trailing: 32))
            
 /*           VStack(alignment: .leading){
                Text("E Mail").font(.headline).foregroundColor(mainColor)
                TextField("write your email", text: $email
                ).background(mainColor).autocapitalization(.none)
            }.padding(16)
            VStack(alignment: .leading){
                Text("Password").font(.headline).foregroundColor(mainColor)
                TextField("write your password", text: $password).background(mainColor).autocapitalization(.none)
            }.padding(16)
            VStack(alignment: .leading){
                Text("Password Again").font(.headline).foregroundColor(mainColor)
                TextField("write your password", text: $password2).background(mainColor).autocapitalization(.none)
            }.padding(16)*/
            
            
            
            Button(action: {
                print("register button clicked")
                self.register()
                
            }, label:{
                HStack(){
                    Text("REGISTER").foregroundColor(Color.white)
                        .padding()
                        .font(.headline)
                }.frame(minWidth:0 ,maxWidth: .infinity)
                .background(mainColor)
                .cornerRadius(8.0).padding(EdgeInsets(top: 16, leading: 32, bottom: 64, trailing: 32))
            }).alert(isPresented: $showAlert) {
                Alert(title: Text(alertMessage), dismissButton: .default(Text("Got it!")))
            }
            
            
            NavigationLink(destination: VerificationView(), isActive: $registered) {
                EmptyView()
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
