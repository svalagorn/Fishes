//
//  AppCoordinator.swift
//  Fishes
//
//  Created by Devs on 2022-09-07.
//

import Foundation
import UIKit

class MainCoordinator : Coordinator {
    var parent: Coordinator? 
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    func launch() {
        goToSpeciesListPage()
    }
    
    let storyboard = UIStoryboard.init(name: "Main", bundle: .main)

}

extension MainCoordinator : SpeciesListNavigationProtocol {
    func goToSpeciesListPage(){
        let apiService = ApiService.init()
        let speciesListViewModel = SpeciesListViewModel.init(nav: self, apiService: apiService)

        //den här init injectorn kräver ios 13
        let speciesListViewController = storyboard.instantiateViewController(identifier: "speciesListViewController", creator: { coder -> SpeciesListViewController? in
            SpeciesListViewController(coder: coder, viewModel: speciesListViewModel)
        })

        navigationController.pushViewController(speciesListViewController, animated: true)
    }
    
    func goToDetailsView(tappedSpecies: Species) {
        let speciesDetailsViewModel = SpeciesDetailsViewModel.init() //nav not needed
        speciesDetailsViewModel.species = tappedSpecies
        
        let speciesDetailsViewController = storyboard.instantiateViewController(identifier: "speciesDetailsViewController", creator: { coder -> SpeciesDetailsViewController? in
            SpeciesDetailsViewController(coder: coder, viewModel: speciesDetailsViewModel)
        })

        navigationController.pushViewController(speciesDetailsViewController, animated: true)
    }
}
