//
//  ArticlesListView.swift
//  NewsApp
//
//  Created by Lluis Armengol on 25/02/2022.
//

import SwiftUI


/****
This view is represents one row of the list where the articles are displayed
 */
struct ArticlesListView: View {
    
    var article: News.Article
    
    var body: some View {
        
        NavigationLink(destination: ArticleView(article: article)) {
            HStack {
                // MARK: TITLE AND SOURCE
                VStack (alignment: .leading, spacing: 5) {
                    Text(article.title ?? "article not found...")
                        .bold()
                        .multilineTextAlignment(.leading)
                        .font(.footnote)
                    
                    Text(article.source.name ?? "no information")
                        .font(.caption2)
                        .italic()
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                // MARK: IMAGE
                if article.urlToImage != nil {
                    // From iOS 15 the method AsyncImage is available for images from URL
                    if #available(iOS 15.0, *) {
                        AsyncImage(
                            url: URL(string: article.urlToImage!),
                            content: { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            }, placeholder: {
                                Color.gray
                            })
                            .frame(width: 100, height: 70)
                            .mask(RoundedRectangle(cornerRadius: 5))
                    } else {
                        // to do method for iOS version < 15.0
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.gray)
                            .frame(width: 100, height: 70)
                    }
                }
            }
            .frame(height: 80)
        }
    }
}

struct ArticlesListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesListView(article: News.Article.init(source: News.Article.Source.init(id: "", name: "Source"), author: "Author", title: "Sanctions contre la Russie : \"Je suis ?? peu pr??s persuad?? que ??a ne servira ?? rien sinon ?? rendre la vie plus - Franceinfo", description: "Description of the article", url: "url", urlToImage: "https://static.lematin.ma/files/lematin/images/articles/2022/02/a9f70f9c6813c82226b4555eeae4737d.jpg", publishedAt: Date(), content: "Content"))
    }
}
