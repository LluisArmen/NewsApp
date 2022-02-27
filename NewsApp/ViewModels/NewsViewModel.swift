//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Lluis Armengol on 24/02/2022.
//

import Foundation

class NewsViewModel: ObservableObject {
    
    @Published var articles = [News.Article]()
    
    /**
     Function to get the news from the API and store them into an array of Articles
        Input:
            url: URL
     
     URLSession method is used, who calls the API asynchronously so the response of the request must be handled using closures
     */
    func getNews(_ opt: [URLQueryItem]? = nil, completion: @escaping(Bool, String) -> Void) {
        print("\n--> Getting news from API...")
        
        let url = getNewsURL(opt)
        
        print(url!)
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(false, error.localizedDescription)
            } else {
                guard let data = data else {
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    
                    // This decoding strategy is required to have the correct format of the date
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let newsFeed = try decoder.decode(News.self, from: data)
                    print("\n*************")
                    print(newsFeed)
                    DispatchQueue.main.async {
                        print("done")
                        self.articles.removeAll()
                        self.articles = newsFeed.articles
                        completion(true, "")
                    }
                } catch let decodeError as NSError {
                    print("\n<<< Decode JSON Failed: \(decodeError) >>>")
                    completion(false, decodeError.localizedDescription)
                }
            }
        }.resume()
    }
    
    
    /**
     Function to ge the news URL from the options array provided by the user
        Output:
            url: URL
     */
    func getNewsURL(_ opt: [URLQueryItem]? = nil) -> URL? {
        
        // Get news Endpoints and options
        var (newsEndpoint, options) = self.getNewsOptions(opt)
        if opt != nil {
            options = opt
        }
        // URL must start with one of the Endpoints
        var newsUrl = newsEndpoint
        
        // Append API KEY
        newsUrl?.queryItems?.append(K.apiKey)
        
        // Add options to the url
        for op in options! {
            newsUrl?.queryItems?.append(op)
        }
        return newsUrl?.url
    }
    
    
    /**
     Function to ge the news Options
        Output:
            options: (URLComponents, [URLQueryItem])
     */
    func getNewsOptions(_ opt: [URLQueryItem]? = nil) -> (URLComponents?, [URLQueryItem]?) {
        let newsEndpoint = K.EndPoints.topHeadlines
        var newsOptions = [URLQueryItem]()
        
        if opt == nil {
            newsOptions.append(K.QueryParam.language)
        } else {
            newsOptions = opt!
        }
        
        return (newsEndpoint, newsOptions)
    }
    
}
