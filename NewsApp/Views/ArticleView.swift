//
//  ArticleView.swift
//  NewsApp
//
//  Created by Lluis Armengol on 25/02/2022.
//

import SwiftUI


/****
This view is used to show the detail of an article
 */
struct ArticleView: View {
    
    var article: News.Article
    
    var body: some View {
        
        ScrollView {
            VStack {
                // MARK: TITLE
                Text(article.title ?? "No title")
                    .bold()
                    .font(.title)
                    .padding()
                
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
                                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width*9/16)
                            })
                            .padding()
                            .mask(RoundedRectangle(cornerRadius: 5))
                    } else {
                        // to do method for iOS version < 15.0
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.gray)
                            .frame(width: 100, height: 70)
                    }
                }
                
                // MARK: DESCRIPTION
                Text(article.description ?? "No description found...")
                    .multilineTextAlignment(.center)
                    .padding()
                
                // MARK: URL
                if article.url != nil {
                    Link( destination: URL(string: article.url!)!) {
                        Text("Read more...")
                            .italic()
                            .padding()
                    }
                } else {
                    Text("No more information available at the moment")
                        .italic()
                        .padding()
                }
            }
        }
    }
}



struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: News.Article.init(source: News.Article.Source.init(id: "", name: "Source"), author: "Author", title: "This is a Title", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", url: "url", urlToImage: "https://static.lematin.ma/files/lematin/images/articles/2022/02/a9f70f9c6813c82226b4555eeae4737d.jp", publishedAt: Date(), content: "Content"))
    }
}
