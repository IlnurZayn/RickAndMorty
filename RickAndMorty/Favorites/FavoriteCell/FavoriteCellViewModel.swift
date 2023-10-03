//
//  FavoriteCellViewModel.swift
//  RickAndMorty
//
//  Created by Ilnur on 03.10.2023.
//

import Foundation

protocol FavoriteCellViewModelProtocol: AnyObject {
    var imageData: Data? { get }
    var name: String { get }
    
    init(character: Character)
}

class FavoriteCellViewModel: FavoriteCellViewModelProtocol {
    
    var imageData: Data? {
        Data()
    }
    
    var name: String {
        "Ilnur"
    }
    
    private let character: Character
    
    required init(character: Character) {
        self.character = character
    }
    
    
}
