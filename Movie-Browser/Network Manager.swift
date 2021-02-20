//
//  Network Mnager.swift
//  Movie-Browser
//
//  Created by Alex Paul on 2/19/21.
//

import UIKit

class NetworkManger{
   
    enum EndPoint{
       case showList
    }
    
    static let shared = NetworkManger()
    private let baseURL : String
    private var  apiKeyPathCompononent :String
    let cache = NSCache<NSString, UIImage>()
   
    private init(){
        self.baseURL = "https://api.themoviedb.org/3/movie/now_playing?"
        self.apiKeyPathCompononent =  "api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    }
 
    private var jsonDecoder:JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    
    
    func get(_ endPoints: EndPoint, urlString: String,  completed:@escaping(Result<Movies,ErroMessage>)->Void){
        guard let url = urlBuilder(endPoint: endPoints) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode==200 else {
                print(ErroMessage.invalidResponse.rawValue)
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            do{
                let apiResponse = try self.jsonDecoder.decode(Movies.self, from: data)
                DispatchQueue.main.async {
                    completed(.success(apiResponse))
                }
                
            } catch{
                print( error)
            }
        }
        task.resume()
    }
    
 
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) { // downloads image
        let cacheKey = NSString(string: urlString) // creates cacheKey to store in image variable
        let imagesBaseURLSTring = "https://image.tmdb.org/t/p/w185"
        guard let url = URL(string: imagesBaseURLSTring + urlString) else {
            completed(nil)
            return
        }
        
        if let image = cache.object(forKey: cacheKey) { // check if image is there
            completed(image)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.cache.setObject(image, forKey: cacheKey)
                completed(image)
            }
        }
        task.resume()
    }
    
    private func urlBuilder(endPoint:EndPoint )->URL?{
        switch endPoint {
        case .showList:
            return URL(string: baseURL + apiKeyPathCompononent )
        }
    }
    
    
    
  
    
}

