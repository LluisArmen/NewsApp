//
//  Constants.swift
//  NewsApp
//
//  Created by Lluis Armengol on 23/02/2022.
//

import Foundation


/****
 This file is used to store static (constant) parameters and that can be accessible from anywhere of the code
    - The information from  https://newsapi.org/docs/ has been used
 */
struct K {
    // The News API has 2 main Endpoints (for the moment the 3rd is not used)
    struct EndPoints {
        static let everything = URLComponents(string: "https://newsapi.org/v2/everything?")
        static let topHeadlines = URLComponents(string: "https://newsapi.org/v2/top-headlines?")
    }
    
    // There are a lot of query parameters, but for the moment only the language is used
    struct QueryParam {
        static let language = URLQueryItem(name: "language", value: "fr")
    }
    
    // The API key
    static let apiKey = URLQueryItem(name: "apiKey", value: "0a8761e3b54a4ee5b51b7c99eafff3eb")
    
}
