//
//  CharacterCellViewModel.swift
//  RickAndMorty
//
//  Created by Ilnur on 02.10.2023.
//

import Foundation

//MARK: - Protocol
protocol CharacterCellViewModelProtocol: AnyObject {
    var name: String { get }
    var status: String { get }
    var species: String { get }
    var gender: String { get }
    var fullStatus: String { get }
    var image: String { get }
    
    init(character: Character)
}

//MARK: - Class
final class CharacterCellViewModel: CharacterCellViewModelProtocol {  // избавиться от VM
    
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
    
    var image: String {
        character.image
    }
    
    private let character: Character
    
    required init(character: Character) {
        self.character = character
    }
}
