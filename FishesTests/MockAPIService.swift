//
//  MockAPIService.swift
//  FishesTests
//
//  Created by Erik on 2022-09-08.
//

import Foundation
@testable import Fishes
class MockApiService : ApiServiceProtocol {
    var isGetAllSpeciesCalled = false
    var completeClosure: ((Result<[Species], Error>) -> Void)!
    
    func getAllSpecies(completion: @escaping (Result<[Species], Error>) -> Void) {
        isGetAllSpeciesCalled = true
        completeClosure = completion
    }
    
    func getAllSuccess() {
        let res = Result<[Species], Error>.init {
            [Species]()
        }
        
        completeClosure(res)
    }
    
    func getAllFailure(error: Error) {
        let res = Result<[Species], Error>.init {
            throw ApiError.connectionError
        }
        
        completeClosure(res)
    }
}
