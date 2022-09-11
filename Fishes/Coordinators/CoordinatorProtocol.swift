//
//  Coordinator.swift
//  Fishes
//
//  Created by Devs on 2022-09-07.
//

import Foundation
import UIKit

protocol Coordinator {
    var parent: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func launch()
}
