//
//  Constants.swift
//  NewsApp
//
//  Created by Lluis Armengol on 23/02/2022.
//

import Foundation

struct K {
    
    struct EndPoints {
        static let everything = URLComponents(string: "https://newsapi.org/v2/everything?")
        static let topHeadlines = URLComponents(string: "https://newsapi.org/v2/top-headlines?")
    }
    
    struct QueryParam {
        static let language = URLQueryItem(name: "language", value: "fr")
    }
    
    static let apiKey = URLQueryItem(name: "apiKey", value: "0a8761e3b54a4ee5b51b7c99eafff3eb")
    
}
