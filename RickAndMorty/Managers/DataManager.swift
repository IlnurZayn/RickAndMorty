//
//  DataManager.swift
//  RickAndMorty
//
//  Created by Ilnur on 03.10.2023.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults()
    
    init() { }
    
    func setFavoriteStatus(for characterName: String, with status: Bool) {
        userDefaults.setValue(status, forKey: characterName)
    }
    
    func getFavoriteStatus(for characterName: String) -> Bool {
        userDefaults.bool(forKey: characterName)
    }
}
