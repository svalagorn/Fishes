//
//  SpeciesListNavigation.swift
//  Fishes
//
//  Created by Devs on 2022-09-07.
//

import Foundation
protocol SpeciesListNavigationProtocol : AnyObject {
    func goToSpeciesListPage()
    func goToDetailsView(tappedSpecies: Species)
}
