//
//  ApiServiceProtocol.swift
//  Fishes
//
//  Created by Erik on 2022-09-08.
//

protocol ApiServiceProtocol {
    func getAllSpecies(completion: @escaping (Result<[Species], Error>) -> Void)
}
