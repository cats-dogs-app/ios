//
//  AppRootView.swift
//  CatsAndDogs
//
//  Created by Halil Ibrahim Kasapoglu on 10.01.2021.
//  Copyright © 2021 Halil Ibrahim Kasapoglu. All rights reserved.
//

import SwiftUI
import Firebase

class AppState: ObservableObject {
    @Published var state = "Auth"

    init(state: String) {
        self.state = state
    }
    func changeState(state : String){
        self.state = state
    }
}

struct AppRootView: View {
    @EnvironmentObject var appState : AppState
    private var modelData = ModelData()

    var body: some View {
        
        Group{
            if appState.state == "Main"{
                MainView().environmentObject(modelData)
            }else {
                LoginWelcomeView().environmentObject(modelData)
            }
        }
    }
}

struct AppRootView_Previews: PreviewProvider {
    static var previews: some View {
        AppRootView()
    }
}
