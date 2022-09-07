//
//  ApiService.swift
//  Fishes
//
//  Created by Devs on 2022-09-07.
//

import Foundation

class ApiService : ApiServiceProtocol {
    fileprivate let baseurl = "https://www.fishwatch.gov/api/species"
    
    deinit {
        print("apiservice deinit")
    }
    
    func getAllSpecies(completion: @escaping (Result<[Species], Error>) -> Void) {
        guard Reachability.isConnectedToNetwork(), let url = URL(string: baseurl) else {
            completion(.failure(ApiError.connectionError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let err = error {
                completion(.failure(err))
                return
            }
            
            guard data != nil else {
                completion(.failure(ApiError.noDataError))
                return
            }

            do {
                //Jäkla Sugar Kelp ställde till det ^^ men med nedan lösning kan man skippa enskilda korrupta element i responselistan
                //https://stackoverflow.com/questions/46344963/swift-jsondecode-decoding-arrays-fails-if-single-element-decoding-fails
                let speciesArrayThrowable = try JSONDecoder().decode([Throwable<Species>].self, from: data!)
                let validSpecies = speciesArrayThrowable.compactMap { try? $0.result.get() }
                
                completion(.success(validSpecies))
            } catch let decodeError {
                print(decodeError)
                completion(.failure(decodeError))
            }
        }.resume()
    }
}
