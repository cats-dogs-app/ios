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

struct MotionView: View {
    @State private var steps : Int?
    
    private let pedometer : CMPedometer = CMPedometer()
    private var isPedometerAvailable: Bool {
        return CMPedometer.isPedometerEventTrackingAvailable() && CMPedometer.isDistanceAvailable() && CMPedometer.isStepCountingAvailable()
    }
    
    func initializePedometer(){
        
        if isPedometerAvailable{
            
            guard let startDate = Calendar.current.date(byAdding: .day,value: -7, to: Date()) else {
                return
            }
            pedometer.queryPedometerData(from: startDate, to: Date()) { (data, error) in
                guard let data = data, error == nil else {print("no pedometer data mate"); return }
                steps = data.numberOfSteps.intValue
                print(data)
                print(steps ?? " --- ")
            }
        }else {
            print("pedometer not available mate")
        }
    }
    
    
    
    var body: some View {
        VStack(){
            Text("Motion Data")
            Divider()
            Text("Total Step")
            Text((steps != nil) ? "\(steps!)" : " ").onAppear(perform: {
                self.initializePedometer();
            })
            
        }.background(Color.blue)
        //background(Color.blue)
    }
}


struct MainView: View {
    @EnvironmentObject var appState : AppState
    
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
                Text("Cats")
            }
            DogsTabView().tabItem{
                Image(systemName: "person")
                Text("Dogs")
            }
            StatsTabView().tabItem{
                Image(systemName: "pencil")
                Text("Stats")
            }
            PedometerView().tabItem {
                Image(systemName: "heart")
                Text("Pedometer")
            }
        }
        
        
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


