//
//  NewsManager.swift
//  NewsApp
//
//  Created by Muhammadjon Loves on 7/6/22.
//

import Foundation

class NewsManager {
    
    static let shared = NewsManager()
    
    let newsAPI = "https://newsapi.org/v2/top-headlines?"
    let apiKey = "489e5b6df4784fc29f3e9623a4c8b6b0"

    func fetchNEWS(userComplitionHandler: @escaping (Result<[Articles], Error>) -> Void) {
        let urlString = "\(newsAPI)?q=Apple&country=us&apiKey=\(apiKey)"
        let url = URL(string: urlString)
        let sesson = URLSession(configuration: .default)
        let task = sesson.dataTask(with: url!) { data, respose, error in
            if error != nil {
                print("There was an error while connecting")
                userComplitionHandler(.failure(error!))
                return
            }
            if let safeData = data {
                let parsedData = self.parseJSON(safeData)
                userComplitionHandler(.success(parsedData!.articles))
            }
        }
        // 4. Start the task!
        task.resume()
        
    }

    func parseJSON(_ newsData: Data) -> NewsData? {
        let decoder = JSONDecoder()
        do {
           let decodedData = try decoder.decode(NewsData.self, from: newsData)
            return decodedData
        } catch {
            print("Error")
            print(error)
            return nil
        }
    }
}

