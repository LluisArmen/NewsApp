//
//  ShowArticlesView.swift
//  NewsApp
//
//  Created by Lluis Armengol on 24/02/2022.
//

import SwiftUI

struct ShowArticlesView: View {
    
    @EnvironmentObject var newsViewModel: NewsViewModel
    
    var body: some View {
        
        List(newsViewModel.articles, id: \.id) {article in
            ArticlesListView(article: article)
        }
        .navigationBarTitle(Text("Your Articles"))
        .navigationViewStyle(.automatic)
    }
}

struct ShowArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        ShowArticlesView()
    }
}
