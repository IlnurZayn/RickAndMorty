//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Ilnur on 02.10.2023.
//

import Foundation

protocol CharacterDetailViewModelProtocol: AnyObject {
    init(character: Character)
}

class CharacterDetailViewModel: CharacterDetailViewModelProtocol {
    
    private let character: Character
    
    required init(character: Character) {
        self.character = character
    }
}
