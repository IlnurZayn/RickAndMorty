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
    
    func setFavoriteStatus(for character: Int) {
        guard var values = userDefaults.array(forKey: DataManager.shared.characterIdKey) as? [Int] else {
            let firstId = [character]
            userDefaults.set(firstId, forKey: DataManager.shared.characterIdKey)
            return
        }
        
        values.append(character)
        userDefaults.set(values, forKey: DataManager.shared.characterIdKey)
    }

    func getFavoriteStatus(for character: Int) -> Bool {
        guard let values = userDefaults.array(forKey: DataManager.shared.characterIdKey) as? [Int] else { return false }
        return values.contains(character)
    }
    
    func removeValue(for character: Int) {
        guard var values = userDefaults.array(forKey: DataManager.shared.characterIdKey) as? [Int],
              let index = values.firstIndex(of: character) else { return }
        values.remove(at: index)
        userDefaults.set(values, forKey: DataManager.shared.characterIdKey)
    }
    
    func getFavorites() -> [Int] {
        guard let values = userDefaults.array(forKey: DataManager.shared.characterIdKey) as? [Int] else { return [] }
        return values
    }
}
