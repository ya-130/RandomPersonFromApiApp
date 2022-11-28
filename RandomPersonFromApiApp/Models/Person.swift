//
//  Person.swift
//  RandomPersonFromApiApp
//
//  Created by Egor Yakovin on 28.11.2022.
//

import Foundation

struct Person: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let picture: Picture
}

struct Name: Decodable {
    let first: String
    let last: String
}

struct Location: Decodable {
    let city: String
    let country: String
}

struct Picture: Decodable {
    let large: String
}
