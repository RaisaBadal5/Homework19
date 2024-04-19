//
//  imediNewsModel.swift
//  ImediNews
//
//  Created by Default on 19.04.24.
//

import UIKit

enum NetworkError: Error {
    case decodeError
    case wrongResponse
    case wrongStatusCode(code: Int)
}

class imediNewsModel: Codable {
    var Title: String?
    var Time: String?
    var PhotoUrl: URL?
    
    init(Title: String? = nil, Time: String? = nil, PhotoUrl: URL? = nil) {
        self.Title = Title
        self.Time = Time
        self.PhotoUrl = PhotoUrl
    }
}

class NetworkService {
    func getData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> Void) {
           guard let url = URL(string: urlString) else {
               completion(nil, NetworkError.wrongResponse)
               return
           }

           URLSession.shared.dataTask(with: url) { data, response, error in
               if let error = error {
                   completion(nil, error)
                   return
               }
               
               guard let httpResponse = response as? HTTPURLResponse,
                     (200...299).contains(httpResponse.statusCode) else {
                   completion(nil, NetworkError.wrongResponse)
                   return
               }

               guard let data = data else {
                   completion(nil, NetworkError.decodeError)
                   return
               }

               do {
                   let decoder = JSONDecoder()
                   let object = try decoder.decode(T.self, from: data)
                   completion(object, nil)
               } catch {
                   completion(nil, NetworkError.decodeError)
               }
           }.resume()
       }
}
