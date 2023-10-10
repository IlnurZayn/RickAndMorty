//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Ilnur on 01.10.2023.
//


import Foundation

struct CharacterModel: Codable {
    let info: Info
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: Gender
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
}

struct Info: Codable {
    let count, pages: Int
}

struct Location: Codable {
    let name: String
}

struct Origin: Codable {
    let name: String
}

enum Gender: String, Codable {
    case genderless = "Genderless"
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}
