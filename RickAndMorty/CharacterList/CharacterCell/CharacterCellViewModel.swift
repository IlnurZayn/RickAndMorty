//
//  CharacterCellViewModel.swift
//  RickAndMorty
//
//  Created by Ilnur on 02.10.2023.
//

import Foundation

protocol CharacterCellViewModelProtocol: AnyObject {
    var imageData: Data? { get }
    var name: String { get }
    var status: String { get }
    var species: String { get }
    var gender: String { get }
    var fullStatus: String { get }
    
    init(character: Character)
}

final class CharacterCellViewModel: CharacterCellViewModelProtocol {
    
    var imageData: Data? {
        ImageManager.shared.fetchImageData(from: character.image)
    }
    
    var name: String {
        character.name
    }
    
    var status: String {
        character.status
    }
    
    var species: String {
        character.species
    }
    
    var gender: String {
        character.gender
    }
    
    var fullStatus: String {
        "\(status) - \(species) - \(gender)"
    }
    
    private let character: Character
    
    required init(character: Character) {
        self.character = character
    }
}
