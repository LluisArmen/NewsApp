//
//  News.swift
//  NewsApp
//
//  Created by Lluis Armengol on 24/02/2022.
//

import Foundation

struct News: Codable {
    
    let status: String?
    let totalResults: Int?
    let articles: [Article]
    
    struct Article: Codable {
        let source: Source
        let author: String?
        let title: String?
        let description: String?
        let url: String?
        let urlToImage: String?
        let publishedAt: Date
        let content: String?
        var id: String {
            url ?? UUID().uuidString
        }
        
        struct Source: Codable {
            var id: String?
            let name: String?
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
    }
    
}
