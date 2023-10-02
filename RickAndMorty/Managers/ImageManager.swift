//
//  ImageManager.swift
//  RickAndMorty
//
//  Created by Ilnur on 02.10.2023.
//

import Foundation
import UIKit

class ImageManager {
    
    static let shared = ImageManager()
    
    var data = Data()
    
    private init() { }
//    
//    func fetchImageData(from urlString: String?) -> Data? {
//     
//        let queue = DispatchQueue(label: "queu")
//        
//        queue.async {
//            guard let urlString = urlString,
//                  let url = URL(string: urlString),
//                  let imageData = try? Data(contentsOf: url) else { return }
//            
//            self.data = imageData
//        }
//        
//        //DispatchQueue.global().async {
//            
//        //}
//        
//        
//        
//        
//        
//        return data
//    }
    
    func fetchImageData(from urlString: String?) -> Data? {
                guard let urlString = urlString,
                      let url = URL(string: urlString),
                      let imageData = try? Data(contentsOf: url) else { return nil }
                return imageData
        
        //        guard let urlString = urlString,
        //              let url = URL(string: urlString) else { return }
        //
        //        let session = URLSession.shared
        //        let task = session.dataTask(with: url) { data, response, error in
        //            if let error = error {
        //                print("Ошибка при загрузке данных: \(error)")
        //                completion(nil)
        //            } else if let data = data {
        //                completion(data)
        //            } else {
        //                completion(nil)
        //            }
        //        }
        //        task.resume()
//        return Data()
    }
}
