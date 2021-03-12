//
//  Deneme.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 26.02.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import SwiftUI

struct Card : View {
    
    @State var pet : Pet
    
    var body: some View{
        HStack(){
            HStack(){
                Image("Dog").resizable().aspectRatio(contentMode: .fit).clipShape(Circle()).overlay(Circle().stroke(Color("Color-2") , lineWidth: 10))
                
                    //.resizable().aspectRatio(contentMode: .fit).padding()
                VStack(alignment:.leading){
                    Text(pet.name).foregroundColor(Color("Color-2")).font(.title)
                    Text("\(pet.weight) kg" ).foregroundColor(Color("Color-2")).font(.subheadline)
                }.padding()
            }.padding()
            Spacer()
        }.frame( maxWidth: .infinity, idealHeight: 128 ,  alignment: .center).background(Color("Primary")).cornerRadius(16.0).padding().shadow(radius: 4)
    }
}

struct Deneme: View {
    @State var pets: [Pet] = [Pet() , Pet() , Pet()]
    
    var body: some View {
        
        VStack(){
            ScrollView(){
                ForEach(pets, id:\.self){
                    pet in Card(pet:pet)
                }
            }
        }
    }
}

struct Deneme_Previews: PreviewProvider {
    static var previews: some View {
        Deneme()
    }
}
