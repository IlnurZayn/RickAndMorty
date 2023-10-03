//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Ilnur on 02.10.2023.
//

import Foundation

protocol CharacterDetailViewModelProtocol: AnyObject {
    var name: String { get }
    var species: String { get }
    var gender: String { get }
    var status: String { get }
    var imageData: Data? { get }
    var isFavorite: Bool { get }
    var viewModelDidChange: ((CharacterDetailViewModelProtocol) -> Void)? { get }
    
    init(character: Character)
    
    func favoriteButtonPressed()
}

class CharacterDetailViewModel: CharacterDetailViewModelProtocol {
    
    var name: String {
        character.name
    }
    
    var species: String {
        character.species
    }
    
    var gender: String {
        character.gender
    }
    
    var status: String {
        character.status
    }
    
    var imageData: Data? {
        ImageManager.shared.fetchImageData(from: character.image)
    }
    
    var isFavorite: Bool {
        get {
            DataManager.shared.getFavoriteStatus(for: character.name)
        }
        set {
            DataManager.shared.setFavoriteStatus(for: character.name, with: newValue)
            viewModelDidChange?(self)
        }
    }
    
    var viewModelDidChange: ((CharacterDetailViewModelProtocol) -> Void)?
    
    private let character: Character
    
    required init(character: Character) {
        self.character = character
    }
    
    func favoriteButtonPressed() {
        isFavorite.toggle()
    }
}
