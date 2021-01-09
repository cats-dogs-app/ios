//
//  VerificationView.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 9.01.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import SwiftUI
import Firebase

struct VerificationView: View {
    
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
    func verify(){
        print("verifying : " + (Auth.auth().currentUser?.email ?? " null "))
        
        Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
            print(error ?? "No error go check your email")
        })
    }
    
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center) {
                Text("We have sent you a verfication email. Go check it!").foregroundColor(mainColor)
                
                Text("Didn't you get one?").foregroundColor(mainColor)
                Button(action: {
                    print("sent again")
                    self.verify()
                }, label:{
                    HStack(){
                        Text("SEND VERIFICATION").foregroundColor(Color.white)
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
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView()
    }
}
