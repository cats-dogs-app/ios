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
    
    func verify(){
        print("verifying : " + (Auth.auth().currentUser?.email ?? " null "))
        
        Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
            print(error ?? "No error go check your email")
        })
    }
        
    var body: some View {
        NavigationView{
            
            VStack(alignment: .center) {
                Text("We have sent you a verfication email. Go check it! After verification you can proceed to login page").foregroundColor(mainColor)
                
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
            }
        }
    }
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView()
    }
}
