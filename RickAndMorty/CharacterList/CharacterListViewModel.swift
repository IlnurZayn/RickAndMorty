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
    var displayedCharacters: [Character] { get }
    var pages: Int? { get }
    var isFavorites: Bool { get }

    func fetchPages(completion: @escaping () -> Void)
    func fetchCharacters(completion: @escaping () -> Void)
    func filterCharacters(showFavoritesOnly: Bool, text: String)
    func search(by text: String)
    func numberOfItems() -> Int
    func cellViewModel(at indexPath: IndexPath) -> CharacterCellViewModelProtocol
    func viewModelForSelectedItem(at indexPath: IndexPath) -> CharacterDetailViewModelProtocol
}

//MARK: - Class
final class CharacterListViewModel: CharacterListViewModelProtocol {
    
    
    var characters: [Character] = []
    
    var favoritesCharacters: [Character] = []
    
    var displayedCharacters: [Character] = []
    
    var pages: Int?
    
    var isFavorites: Bool = false
    
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
                self.displayedCharacters = self.characters
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    func numberOfItems() -> Int {
        displayedCharacters.count
    }
    
    func filterCharacters(showFavoritesOnly: Bool, text: String) {
        if text != "" {
            if showFavoritesOnly {
                isFavorites = true
                favoritesCharacters = characters.filter { DataManager.shared.getAllKeys().contains($0.image) }
                displayedCharacters = favoritesCharacters
                search(by: text)
            } else {
                isFavorites = false
                search(by: text)
            }
        } else {
            if showFavoritesOnly {
                favoritesCharacters = characters.filter { DataManager.shared.getAllKeys().contains($0.image) }
                displayedCharacters = favoritesCharacters
                isFavorites = true
            } else {
                displayedCharacters = characters
                isFavorites = false
            }
        }
        
        
    }
    
    func search(by text: String) {
        let filteredAllCharacters = characters.filter { $0.name.lowercased().contains(text.lowercased()) }
        let filteredFavoritesCharacters = favoritesCharacters.filter { $0.name.lowercased().contains(text.lowercased()) }
        
        if text != "" {
            displayedCharacters = isFavorites ? filteredFavoritesCharacters : filteredAllCharacters
        } else {
            displayedCharacters = isFavorites ? favoritesCharacters : characters
        }
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CharacterCellViewModelProtocol {
        let character = displayedCharacters[indexPath.item]
        return CharacterCellViewModel(character: character)
    }
    
    func viewModelForSelectedItem(at indexPath: IndexPath) -> CharacterDetailViewModelProtocol {
        let character = displayedCharacters[indexPath.item]
        return CharacterDetailViewModel(character: character)
    }
}
