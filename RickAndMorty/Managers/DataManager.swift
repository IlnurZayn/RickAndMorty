//
//  DataManager.swift
//  RickAndMorty
//
//  Created by Ilnur on 03.10.2023.
//

import Foundation

final class DataManager {
    
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults()
    
    init() { }
    
    func setFavoriteStatus(for character: String, with status: Bool) {
        userDefaults.setValue(status, forKey: character)
    }
    
    func getFavoriteStatus(for character: String) -> Bool {
        userDefaults.bool(forKey: character)
    }
    
    func removeValue(for character: String) {
        userDefaults.removeObject(forKey: character)
    }
    
    func getAllKeys() -> [String] {
        Array(DataManager.shared.userDefaults.dictionaryRepresentation().keys)
    }
}
