//
//  Species.swift
//  Fishes
//
//  Created by Devs on 2022-09-07.
//

import Foundation

struct Species: Codable {
    let name: String
    let scientificName: String
    let population: String?
    let images: [SpeciesImage]?
    
    enum CodingKeys: String, CodingKey {
        case name = "Species Name"
        case scientificName = "Scientific Name"
        case population = "Population"
        case images = "Image Gallery"
    }
}

struct SpeciesImage: Codable {
    let src: String
    let alt: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case src = "src"
        case alt = "alt"
        case title = "title"
    }
}



