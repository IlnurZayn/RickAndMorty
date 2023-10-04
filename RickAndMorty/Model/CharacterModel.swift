//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Ilnur on 01.10.2023.
//


import Foundation

struct CharacterModel: Decodable {
    let info: Info
    let results: [Character]
}

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
}

struct Info: Decodable {
    let count, pages: Int
}

struct Location: Decodable {
    let name: String
}

struct Origin: Decodable{
    let name: String
}
