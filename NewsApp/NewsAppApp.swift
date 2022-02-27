//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Lluis Armengol on 23/02/2022.
//

import SwiftUI

@main
struct NewsAppApp: App {
    
    @StateObject var newsViewModel = NewsViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(newsViewModel)
        }
    }
}
