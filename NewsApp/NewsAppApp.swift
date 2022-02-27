//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Lluis Armengol on 23/02/2022.
//

import SwiftUI

@main
struct NewsAppApp: App {
    // The news view model is added here as an environment object to be available in the whole app
    @StateObject var newsViewModel = NewsViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(newsViewModel)
        }
    }
}
