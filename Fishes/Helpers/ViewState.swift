//
//  ViewState.swift
//  Fishes
//
//  Created by Devs on 2022-09-07.
//

import Foundation
enum ViewState { 
    case initial
    case loaded
    case loading
    case error(Error)
}
