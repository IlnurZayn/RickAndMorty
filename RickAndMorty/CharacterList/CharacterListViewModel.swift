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

    func fetchPagesCount()
    func fetchCharacters(completion: @escaping () -> Void)
    func filterCharacters(text: String)
    func searchCharacter(by text: String) -> [Character]
    func numberOfItems() -> Int
    func currentCell(at indexPath: IndexPath) -> Character
    func viewModelForSelectedItem(at indexPath: IndexPath) -> CharacterDetailViewModelProtocol
    func loadNextPage(for indexPath: IndexPath, completion: @escaping () -> Void)
}

//MARK: - Class
final class CharacterListViewModel: CharacterListViewModelProtocol {
    
    var characters: [Character] = []
    var favoritesCharacters: [Character] = []
    var displayedCharacters: [Character] = []
    var currentPage: Int = 1
    var pages: Int?
    var isFavorites: Bool = false
    
    func fetchPagesCount() {
        NetworkManager.shared.fetchData(with: API.baseUrl.rawValue + Endpoint.character.rawValue, 
                                        dataType: CharacterModel.self) { result in
            self.pages = result.info.pages
        }
    }
    
    func fetchCharacters(completion: @escaping () -> Void) {
        
        NetworkManager.shared.fetchData(with: API.baseUrl.rawValue + Endpoint.character.rawValue + Endpoint.page.rawValue + "\(currentPage)",
                                        dataType: CharacterModel.self) { result in
            self.characters.append(contentsOf: result.results)
            self.favoritesCharacters = self.characters
            self.displayedCharacters = self.characters
            completion()
        }
    }
    
    func numberOfItems() -> Int {
        displayedCharacters.count
    }
    
    func filterCharacters(text: String) {
        let characters = searchCharacter(by: text)
        displayedCharacters = isFavorites ? characters.filter { DataManager.shared.getFavorites().contains($0.id) } : characters
    }
    
    func searchCharacter(by text: String) -> [Character] {
        var result = [Character]()
        
        if text.isEmpty {
            result = isFavorites ? favoritesCharacters : characters
        } else {
            let filteredAllCharacters = characters.filter { $0.name.lowercased().contains(text.lowercased()) }
            let filteredFavoritesCharacters = favoritesCharacters.filter { $0.name.lowercased().contains(text.lowercased()) }
            result = isFavorites ? filteredFavoritesCharacters : filteredAllCharacters
        }
        
        return result
    }
    
    func currentCell(at indexPath: IndexPath) -> Character {
        return displayedCharacters[indexPath.item]
    }
    
    func viewModelForSelectedItem(at indexPath: IndexPath) -> CharacterDetailViewModelProtocol {
        let character = displayedCharacters[indexPath.item]
        return CharacterDetailViewModel(character: character)
    }
    
    func loadNextPage(for indexPath: IndexPath ,completion: @escaping () -> Void) {
        guard let pages, currentPage <= pages else { return }
        
        if indexPath.item == (characters.count - 1) {
            self.currentPage += 1
            fetchCharacters {
                completion()
            }
        }
    }
}
