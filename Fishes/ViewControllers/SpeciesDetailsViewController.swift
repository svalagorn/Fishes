//
//  SpeciesDetailsViewController.swift
//  Fishes
//
//  Created by Devs on 2022-09-07.
//

import Foundation
import UIKit

class SpeciesDetailsViewController: UIViewController {
    private let viewModel : SpeciesDetailsViewModel
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var scientificNameLabel : UILabel!
    @IBOutlet weak var infoLabel : UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    init?(coder: NSCoder, viewModel: SpeciesDetailsViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = self.viewModel.species?.name
        imgView.loadRemoteImage(self.viewModel.species?.images?.first?.src ?? "https://assets.puzzlefactory.pl/puzzle/267/792/original.jpg", placeHolder: UIImage(named: "loading"))
        scientificNameLabel.text = self.viewModel.species?.scientificName
        infoLabel.text = self.viewModel.species?.population ?? "No population info"
    }

}
