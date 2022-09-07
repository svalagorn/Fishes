//
//  SpeciesListViewModel.swift
//  Fishes
//
//  Created by Devs on 2022-09-07.
//

import Foundation
final class SpeciesListViewModel {
    weak var navigation : SpeciesListNavigationProtocol!
    weak var updateDelegate: UpdateDelegate?
    var apiService: ApiServiceProtocol!
    
    var state: ViewState {
        didSet { //Har saknat dessa :)
            self.updateDelegate?.didUpdate(with: state)
        }
    }
    
    deinit
    {
        print ("SpeciesListViewModel deinit")
    }
    
    var allSpecies: [Species] = []
    var numberOfItems: Int {
        allSpecies.count
    }
    
    init(nav: SpeciesListNavigationProtocol, apiService: ApiServiceProtocol) {
        self.navigation = nav
        self.apiService = apiService
        self.state = .initial
    }
    
    func loadSpeciesFromAPI() {
        self.state = .loading
        self.apiService.getAllSpecies { result in
            switch result {
            case let .success(species):
                self.allSpecies = species
                self.state = .loaded

            case let .failure(error):
                self.allSpecies = []
                self.state = .error(error)
            }
        }
    }
    
    func getSpeciesInfo(for indexPath: IndexPath) -> (name: String, scientificName: String, population: String?, imageUrl: String?) {
        let species = allSpecies[indexPath.row]
        return (name: species.name,
                scientificName: species.scientificName,
                population: species.population,
                imageUrl: species.images?.first?.src)
    }
    
    func goToDetailsView(tappedSpecies: Species) {
        navigation.goToDetailsView(tappedSpecies: tappedSpecies)
    }
}

