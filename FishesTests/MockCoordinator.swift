//
//  MockCoordinator.swift
//  FishesTests
//
//  Created by Erik on 2022-09-08.
//

import Foundation
@testable import Fishes

class MockCoordinator : SpeciesListNavigationProtocol {
    var wentToDetailsView = false
    func goToDetailsView(tappedSpecies: Species) {
        wentToDetailsView = true
    }
}
