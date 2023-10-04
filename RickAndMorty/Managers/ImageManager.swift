//
//  ImageManager.swift
//  RickAndMorty
//
//  Created by Ilnur on 02.10.2023.
//

import Foundation
import Kingfisher

final class ImageManager {
    
    static let shared = ImageManager()
    
    private init() { }
    
    func fetchImageData(from urlString: String?, completion: @escaping (Data?) -> Void) {
        
        guard let urlString = urlString,
              let url = URL(string: urlString) else { return }
        
        KingfisherManager.shared.retrieveImage(with: url) { result in
            switch result {
            case .success(let value):
                completion(value.data())
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
