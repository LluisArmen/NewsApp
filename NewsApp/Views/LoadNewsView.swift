//
//  LoadNewsView.swift
//  NewsApp
//
//  Created by Lluis Armengol on 24/02/2022.
//

import SwiftUI

struct LoadNewsView: View {
    
    @EnvironmentObject var newsViewModel: NewsViewModel
    @State var loadSuccess: Bool = false
    @State var errorMessage = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
                Group {
                    Text("Welcome")
                        .bold()
                        .font(.largeTitle)
                    
                    Text("With this app you can view the latest news obtained from https://newsapi.org")
                    
                    Text("The default Search Options are: \n \(K.QueryParam.language.name) = \(K.QueryParam.language.value ?? "")")
                }
                .multilineTextAlignment(.center)
                .padding()
                
                
                Button(action: {
                    newsViewModel.getNews() { success, err  in
                        loadSuccess = success
                        print(newsViewModel.articles)
                        if !success {
                            errorMessage = err
                        }
                    }
                }) {
                    VStack {
                        
                        Text("Get the News !")
                            .searchButtonStyle()
                            
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }
                
                Group {
                    if loadSuccess {
                        VStack {
                            HStack {
                                Text("Number of Articles:")
                                Text("\(newsViewModel.articles.count)")
                            }
                            
                            if newsViewModel.articles.count > 0 {
                                NavigationLink(destination: ShowArticlesView()) {
                                    Text("Show Articles")
                                        .showButtonStyle()
                                }
                                
                                Button(action: {
                                    loadSuccess = false
                                }) {
                                    VStack {
                                        Text("Restart")
                                            .italic()
                                    }
                                }
                                .padding(.top, 30)
                            } else {
                                Text("No Articles found with these options...")
                            }
                        }
                    }
                }
                .padding(.top, 100)
                
                
                Spacer()
                
                
            }
        }
        
    }
}

struct LoadNewsView_Previews: PreviewProvider {
    static var previews: some View {
        LoadNewsView(loadSuccess: false,
                     errorMessage: "")
    }
}



extension Text {
    func searchButtonStyle() -> some View {
        self.bold()
            .foregroundColor(.white)
            .frame(width: 200, height: 40, alignment: .center)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding()
    }
    
    func showButtonStyle() -> some View {
        self.bold()
            .foregroundColor(.white)
            .frame(width: 200, height: 40, alignment: .center)
            .background(.green)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding()
    }
}
