//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Ilnur on 02.10.2023.
//

import Foundation

//MARK: - Protocol
protocol CharacterListViewModelProtocol: AnyObject {
    var characters: [Character] { get }
    var favoritesCharacters: [Character] { get }
    var pages: Int? { get }

    func fetchPages(completion: @escaping () -> Void)
    func fetchCharacters(completion: @escaping () -> Void)
    func numberOfItems() -> Int
    func filterCharacters(showFavoritesOnly: Bool)
    func cellViewModel(at indexPath: IndexPath) -> CharacterCellViewModelProtocol
    func viewModelForSelectedItem(at indexPath: IndexPath) -> CharacterDetailViewModelProtocol
}

//MARK: - Class
final class CharacterListViewModel: CharacterListViewModelProtocol {
    
    var characters: [Character] = []
    
    var favoritesCharacters: [Character] = []
    
    var pages: Int?
    
    func fetchPages(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData(with: API.baseUrl.rawValue + Endpoint.character.rawValue, 
                                        dataType: CharacterModel.self) { result in
            self.pages = result.info.pages
            completion()
        }
    }
    
    func fetchCharacters(completion: @escaping () -> Void) {
        
        guard let pages = self.pages else { return }
        
        let dispatchGroup = DispatchGroup()
        
        for page in 1...pages {
            
            dispatchGroup.enter()
            
            NetworkManager.shared.fetchData(with: API.baseUrl.rawValue + Endpoint.character.rawValue + Endpoint.page.rawValue + "\(page)",
                                            dataType: CharacterModel.self) { result in
                self.characters.append(contentsOf: result.results)
                self.favoritesCharacters = self.characters
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    func numberOfItems() -> Int {
        favoritesCharacters.count
    }
    
    func filterCharacters(showFavoritesOnly: Bool) {
        if showFavoritesOnly {
            favoritesCharacters = characters.filter { DataManager.shared.getAllKeys().contains($0.image) }
        } else {
            favoritesCharacters = characters
        }
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CharacterCellViewModelProtocol {
        let character = favoritesCharacters[indexPath.item]
        return CharacterCellViewModel(character: character)
    }
    
    func viewModelForSelectedItem(at indexPath: IndexPath) -> CharacterDetailViewModelProtocol {
        let character = favoritesCharacters[indexPath.item]
        return CharacterDetailViewModel(character: character)
    }
}
