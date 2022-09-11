//
//  MockCoordinator.swift
//  FishesTests
//
//  Created by Erik on 2022-09-08.
//

import Foundation
import UIKit
@testable import Fishes

class MockCoordinator : Coordinator {
    var parent: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    //Spy properties kallas tydligen dessa
    var wentToDetailsView = false
    var wentToListView = false
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func launch() {
        goToSpeciesListPage()
    }
}

extension MockCoordinator : SpeciesListNavigationProtocol {
    func goToSpeciesListPage(){
        wentToListView = true
    }
    func goToDetailsView(tappedSpecies: Species) {
        wentToDetailsView = true
    }
}
