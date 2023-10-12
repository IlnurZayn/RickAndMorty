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
    var currentPage: Int { get }
    var pages: Int? { get }
    var isFavorites: Bool { get }

    func fetchPages()
    func fetchCharacters(completion: @escaping () -> Void)
    func filterCharacters(showFavoritesOnly: Bool, text: String)
    func search(by text: String)
    func numberOfItems() -> Int
    func currentCell(at indexPath: IndexPath) -> Character
    func viewModelForSelectedItem(at indexPath: IndexPath) -> CharacterDetailViewModelProtocol
    func updateCollectionView(completion: @escaping () -> Void)
}

//MARK: - Class
final class CharacterListViewModel: CharacterListViewModelProtocol {
    
    var characters: [Character] = []
    var favoritesCharacters: [Character] = []
    var displayedCharacters: [Character] = []
    var currentPage: Int = 1
    var pages: Int?
    var isFavorites: Bool = false
    
    func fetchPages() {
        NetworkManager.shared.fetchData(with: API.baseUrl.rawValue + Endpoint.character.rawValue, 
                                        dataType: CharacterModel.self) { result in
            self.pages = result.info.pages
        }
    }
    
    func fetchCharacters(completion: @escaping () -> Void) {
        
        NetworkManager.shared.fetchData(with: API.baseUrl.rawValue + Endpoint.character.rawValue + Endpoint.page.rawValue + "\(currentPage)",
                                        dataType: CharacterModel.self) { result in
            self.characters.append(contentsOf: result.results)
            self.displayedCharacters = self.characters
        }
        
        DispatchQueue.main.async {
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
                favoritesCharacters = characters.filter { DataManager.shared.getFavorites().contains($0.id) }
                displayedCharacters = favoritesCharacters
                search(by: text)
            } else {
                isFavorites = false
                search(by: text)
            }
        } else {
            if showFavoritesOnly {
                favoritesCharacters = characters.filter { DataManager.shared.getFavorites().contains($0.id) }
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
    
    func currentCell(at indexPath: IndexPath) -> Character {
        return displayedCharacters[indexPath.item]
    }
    
    func viewModelForSelectedItem(at indexPath: IndexPath) -> CharacterDetailViewModelProtocol {
        let character = displayedCharacters[indexPath.item]
        return CharacterDetailViewModel(character: character)
    }
    
    func updateCollectionView(completion: @escaping () -> Void) {
        guard let pages, currentPage <= pages else { return }
        
            self.currentPage += 1
            fetchCharacters {
                completion()
            }
        
    }
}
