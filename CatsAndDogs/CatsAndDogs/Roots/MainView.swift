//
//  MainView.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 9.01.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import SwiftUI
import Firebase
import CoreMotion



struct MainView: View {
    @EnvironmentObject var appState : AppState
    @EnvironmentObject var modelData : ModelData

    private var tabBarTitleEnabled = false
    
    func logout(){
        
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        appState.state = "Auth"
    }
    
    var body: some View {
        
        TabView(){
            CatsTabView().tabItem{
                Image(systemName: "person")
                if (tabBarTitleEnabled){Text("Cats")}
            }.environmentObject(modelData)
            DogsTabView().tabItem{
                Image(systemName: "person")
                if (tabBarTitleEnabled){Text("Dogs")}
            }.environmentObject(modelData)
            StatsTabView().tabItem{
                Image(systemName: "pencil")
                if (tabBarTitleEnabled){Text("Stats")}
            }
            PedometerView().tabItem {
                Image(systemName: "heart")
                if (tabBarTitleEnabled){Text("Pedometer")}
            }
            FeedsTabView().tabItem {
                Image(systemName: "pencil")
                if (tabBarTitleEnabled){Text("Feeds")}
            }.environmentObject(modelData)
        }
        
        
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


