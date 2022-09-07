//
//  ThrowableDecodable.swift
//  Fishes
//
//  Created by Devs on 2022-09-07.
//

import Foundation
struct Throwable<T: Decodable>: Decodable {
    let result: Result<T, Error>

    init(from decoder: Decoder) throws {
        result = Result(catching: { try T(from: decoder) })
    }
}
