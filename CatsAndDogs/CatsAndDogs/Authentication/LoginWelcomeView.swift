//
//  LoginWelcomeView.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 21.01.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import SwiftUI

struct ArcShape : Shape {
    let geometry: GeometryProxy
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let center = CGPoint(x: rect.width/2 , y: 0) // 1/4 from top
        p.addArc(center: center, radius:  rect.height*3/4, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
        return p
    }
}
struct LoginWelcomeView: View {
    init() {
        let coloredAppearance = UINavigationBarAppearance()
            coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = UIColor(named: "cd_darkgreen")
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                           
            UINavigationBar.appearance().standardAppearance = coloredAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
            UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = UIColor.white

        }
    var body: some View {
        NavigationView(){
            
            VStack(alignment: .leading){
                
                VStack(alignment: .leading){
                    Text("Greetings !").font(.system(size: 48)).bold().foregroundColor(.white).padding(.bottom)
                    Text("Nice to see you back").font(.system(size:24)).foregroundColor(.white)
                }.padding(EdgeInsets(top: 128, leading: 32, bottom: 0, trailing: 0))
                
                Button(action: {}, label: {
                        HStack(){
                            Text("LOGIN").foregroundColor(Color.white)
                                .padding()
                                .font(.headline)
                        }.frame(minWidth:0 ,maxWidth: .infinity)
                            .background(mainColor)
                            .cornerRadius(8.0).padding(32)
                }).padding(.top , 32)
                
                Spacer()
            
                HStack(){
                    Text("Don't have an account ? ").foregroundColor(Color("cd_lightgreen"))
                
                    NavigationLink (
                        destination: LoginView(),
                        label: {
                            Text("Register").foregroundColor(Color("cd_darkgreen"))
                        })
                }.padding(EdgeInsets(top: 0, leading: 32, bottom: 32, trailing: 0))
                
            }.background(
                GeometryReader { geometry in
                          ZStack(alignment: .leading) {
                              Color.white
                              ArcShape(geometry: geometry)
                                  .foregroundColor(Color("cd_lightgreen"))

                          }
                      }
            ).frame(
                minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading).edgesIgnoringSafeArea(.bottom)
                    
            .navigationBarTitle(Text("Cats & Dogs") , displayMode: .inline)
            
        }
    }
}

struct LoginWelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        LoginWelcomeView()
    }
}
