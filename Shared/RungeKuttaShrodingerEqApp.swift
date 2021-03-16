//
//  RungeKuttaShrodingerEqApp.swift
//  Shared
//
//  Created by anthony lim on 3/12/21.
//

import SwiftUI

@main
struct RungeKuttaShrodingerEqApp: App {
    
    @StateObject var plotDataModel = PlotDataClass(fromLine: true)
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .environmentObject(plotDataModel)
                    .tabItem {
                        Text("Plot")
                    }
                TextView()
                    .environmentObject(plotDataModel)
                    .tabItem {
                        Text("Text")
                    }
                            
                            
            }
            
        }
    }
}
