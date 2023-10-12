//
//  DataManager.swift
//  RickAndMorty
//
//  Created by Ilnur on 03.10.2023.
//

import Foundation

final class DataManager {
    
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults.standard
    private let characterIdKey = "id"
    
    init() { }
    
    func setFavoriteStatus(for characterId: Int) {
        guard var values = userDefaults.array(forKey: DataManager.shared.characterIdKey) as? [Int] else {
            let firstId = [characterId]
            userDefaults.set(firstId, forKey: DataManager.shared.characterIdKey)
            return
        }
        
        values.append(characterId)
        userDefaults.set(values, forKey: DataManager.shared.characterIdKey)
    }

    func getFavoriteStatus(for characterId: Int) -> Bool {
        guard let values = userDefaults.array(forKey: DataManager.shared.characterIdKey) as? [Int] else { return false }
        return values.contains(characterId)
    }
    
    func removeValue(for characterId: Int) {
        guard var values = userDefaults.array(forKey: DataManager.shared.characterIdKey) as? [Int],
              let index = values.firstIndex(of: characterId) else { return }
        values.remove(at: index)
        userDefaults.set(values, forKey: DataManager.shared.characterIdKey)
    }
    
    func getFavorites() -> [Int] {
        guard let values = userDefaults.array(forKey: DataManager.shared.characterIdKey) as? [Int] else { return [] }
        return values
    }
}
