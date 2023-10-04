//
//  ImageManager.swift
//  RickAndMorty
//
//  Created by Ilnur on 02.10.2023.
//

import Foundation
import UIKit

final class ImageManager {
    
    static let shared = ImageManager()
    
    var data = Data()
    
    private init() { }
    
    func fetchImageData(from urlString: String?, completion: @escaping (Data?) -> Void) {
        
        guard let urlString = urlString,
              let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, _, _ in            
            guard let data = data else { return }
            
                completion(data)
        }
        
        task.resume()
    }
}
