//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Ilnur on 01.10.2023.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData<T: Decodable>(with stringUrl: String, dataType: T.Type, completion: @escaping (T) -> Void) {
        
        guard let url = URL(string: stringUrl) else { return }
        
        AF.request(url).validate().responseDecodable(of: dataType) { responseData in
            switch responseData.result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
