//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Ilnur on 01.10.2023.
//

import Foundation

final class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchData<T: Decodable>(with urlString: String, dataType: T.Type, completion: @escaping (T) -> Void) {
        
        guard let url = URL(string: urlString) else{ return }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let dataArray = try JSONDecoder().decode(dataType, from: data)
                DispatchQueue.main.async {
                    completion(dataArray)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
