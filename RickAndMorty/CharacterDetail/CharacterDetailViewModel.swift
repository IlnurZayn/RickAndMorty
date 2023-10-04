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
    var isFavorite: Bool { get }
    var viewModelDidChange: ((CharacterDetailViewModelProtocol) -> Void)? { get }
    var imageLoaded: ((Data?) -> Void)? { get }
    
    init(character: Character)
    
    func favoriteButtonPressed()
    func deleteCharacter(forFalse false: Bool)
    func fetchImage()
}

final class CharacterDetailViewModel: CharacterDetailViewModelProtocol {
    
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
    
    var isFavorite: Bool {
        get {
            DataManager.shared.getFavoriteStatus(for: character.image)
        }
        set {
            DataManager.shared.setFavoriteStatus(for: character.image, with: newValue)
            viewModelDidChange?(self)
        }
    }
    
    var viewModelDidChange: ((CharacterDetailViewModelProtocol) -> Void)?
    
    var imageLoaded: ((Data?) -> Void)?
    
    private let character: Character
    
    required init(character: Character) {
        self.character = character
    }
    
    func favoriteButtonPressed() {
        isFavorite.toggle()
    }
    
    func deleteCharacter(forFalse: Bool) {
        if forFalse == false {
            DataManager.shared.removeValue(for: character.image)
        }
    }
    
    func fetchImage() {
        ImageManager.shared.fetchImageData(from: character.image) { [weak self] data in
            guard let self = self else { return }
            self.imageLoaded?(data)
        }
    }
}
