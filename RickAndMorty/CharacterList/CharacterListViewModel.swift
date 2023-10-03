//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Ilnur on 02.10.2023.
//

import Foundation

protocol CharacterListViewModelProtocol: AnyObject {
    var characters: [Character] { get }
    var pages: Int? { get }

    func fetchPages(completion: @escaping () -> Void)
    func fetchCharacters(completion: @escaping () -> Void)
    func numberOfItems() -> Int
    func cellViewModel(at indexPath: IndexPath) -> CharacterCellViewModelProtocol
    func viewModelForSelectedItem(at indexPath: IndexPath) -> CharacterDetailViewModelProtocol
}

class CharacterListViewModel: CharacterListViewModelProtocol {
    
    var characters: [Character] = []
    
    var pages: Int?
    
    func fetchPages(completion: @escaping () -> Void) {
        NetworkService.shared.fetchData(with: fullUrl, dataType: CharacterModel.self) { result in
            self.pages = result.info.pages
            completion()
        }
    }
    
    func fetchCharacters(completion: @escaping () -> Void) {
        
        guard let pages = self.pages else { return }
        
        let dispatchGroup = DispatchGroup()
        
        for page in 1...pages {
            
            dispatchGroup.enter()
            
            NetworkService.shared.fetchData(with: pageUrl + "\(page)", dataType: CharacterModel.self) { result in
                self.characters.append(contentsOf: result.results)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    func numberOfItems() -> Int {
        characters.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CharacterCellViewModelProtocol {
        let character = characters[indexPath.item]
        return CharacterCellViewModel(character: character)
    }
    
    func viewModelForSelectedItem(at indexPath: IndexPath) -> CharacterDetailViewModelProtocol {
        let character = characters[indexPath.item]
        return CharacterDetailViewModel(character: character)
    }
}
