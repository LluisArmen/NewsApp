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
                // MARK: HEADLINE
                /** Welcome message and description
                     - In this version of the code the user cannot interact with this part
                 */
                Group {
                    Text("Welcome")
                        .bold()
                        .font(.largeTitle)
                    
                    Text("With this app you can view the latest news obtained from https://newsapi.org")
                    
                    Text("The default Search Options are: \n \(K.QueryParam.language.name) = \(K.QueryParam.language.value ?? "")")
                }
                .multilineTextAlignment(.center)
                .padding()
                
                // MARK: GET NEWS BUTTON
                /**
                 Button to get the news from the API using the default options:
                    - language : fr
                 */
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
                
                // MARK: RESULTS
                /**
                 If the articles have been read and stored with success, it shows:
                    - The amount of articles found
                    - A button to see the articles list
                    - A button to restart the search (in the future, the user will be able to change the options)
                    
                 If the articles could not be read, it an error message is shown in red
                 */
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


// MARK: EXTENSIONS

// This extension is used to keep the format properties of the buttons in one place
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
