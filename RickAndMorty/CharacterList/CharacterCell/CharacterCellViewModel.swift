//
//  CharacterCellViewModel.swift
//  RickAndMorty
//
//  Created by Ilnur on 02.10.2023.
//

import Foundation

protocol CharacterCellViewModelProtocol: AnyObject {
    var name: String { get }
    var status: String { get }
    var species: String { get }
    var gender: String { get }
    var fullStatus: String { get }
    
    init(character: Character)
    
    func fetchImage(completion: @escaping (Data?) -> Void)
}

final class CharacterCellViewModel: CharacterCellViewModelProtocol {
    
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
    
    func fetchImage(completion: @escaping (Data?) -> Void) {
        ImageManager.shared.fetchImageData(from: character.image) { data in
            completion(data)
        }
    }
}
