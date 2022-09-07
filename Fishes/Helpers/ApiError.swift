//
//  ApiError.swift
//  Fishes
//
//  Created by Devs on 2022-09-07.
//

import Foundation
enum ApiError {
    case noDataError, connectionError
}

extension ApiError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noDataError: return "Ingen data :("
        case .connectionError: return "No internet :/"
        }
    }
}
