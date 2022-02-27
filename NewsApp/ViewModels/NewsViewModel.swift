//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Lluis Armengol on 24/02/2022.
//

import Foundation

class NewsViewModel: ObservableObject {
    
    @Published var articles = [News.Article]()
    
    // MARK: GET NEWS FUNC
    /****
     Function to get the news from the API and store them into an array of Articles
        Input:
            url: URL
     
     URLSession method is used, who calls the API asynchronously so the response of the request must be handled using closures
     */
    func getNews(_ opt: [URLQueryItem]? = nil, completion: @escaping(Bool, String) -> Void) {
        print("\n--> Getting news from API...")
        
        // Get the url of the articles to be decoded
        let url = getNewsURL(opt)
        
        print(url!)
        
        // We use the method URLSession to read the url content
        // Since it is asynchronous we mush use closures
        URLSession.shared.dataTask(with: url!) { data, response, error in
            // Check if error
            if let error = error {
                print(error.localizedDescription)
                completion(false, error.localizedDescription)
            } else {
                guard let data = data else {
                    return
                }
                // Decode the data using JSONDecoder method
                do {
                    let decoder = JSONDecoder()
                    // This decoding strategy is required to have the correct format of the date
                    decoder.dateDecodingStrategy = .iso8601
                    // We first save the news feed inside a let variable
                    let newsFeed = try decoder.decode(News.self, from: data)
                    // Once its is inished we save the data of the articles inside the published var
                    DispatchQueue.main.async {
                        print("done")
                        self.articles.removeAll()
                        self.articles = newsFeed.articles
                        completion(true, "")
                    }
                // If the decoding failed we save and pass the error so it can be printed in the console and screen for the user to know
                } catch let decodeError as NSError {
                    print("\n<<< Decode JSON Failed: \(decodeError) >>>")
                    completion(false, decodeError.localizedDescription)
                }
            }
        }.resume()
    }
    
    
    // MARK: GET URL FUNC
    /****
     Function to ge the news URL from the options array provided by the user
        Output:
            url: URL
     */
    func getNewsURL(_ opt: [URLQueryItem]? = nil) -> URL? {
        
        // Get news Endpoints and options --> we take default options
        var (newsEndpoint, options) = self.getNewsOptions(opt)
        
        // If array of options is provided, we use it
        if opt != nil {
            options = opt
        }
        // URL must start with one of the Endpoints
        var newsUrl = newsEndpoint
        
        // Append API KEY
        newsUrl?.queryItems?.append(K.apiKey)
        
        // Add options to the url by iterating the array of options
        for op in options! {
            newsUrl?.queryItems?.append(op)
        }
        return newsUrl?.url
    }
    
    
    // MARK: GET OPTIONS FUNC
    /****
     Function to ge the news Options
        Output:
            options: (URLComponents, [URLQueryItem])
     */
    func getNewsOptions(_ opt: [URLQueryItem]? = nil) -> (URLComponents?, [URLQueryItem]?) {
        
        // We use the top headlines endpoint by default
        let newsEndpoint = K.EndPoints.topHeadlines
        
        // Create query options array
        var newsOptions = [URLQueryItem]()
        
        // If array of options is not provided, we use language (default)
        if opt == nil {
            newsOptions.append(K.QueryParam.language)
        } else {
            newsOptions = opt!
        }
        
        return (newsEndpoint, newsOptions)
    }
    
}
