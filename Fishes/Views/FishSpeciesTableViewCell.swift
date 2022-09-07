//
//  FishSpeciesTableViewCell.swift
//  Fishes
//
//  Created by Devs on 2022-09-07.
//

import UIKit
import AVFoundation

protocol FishSpeciesTableViewCellDelegate: AnyObject {
    func didClickOnCellSillyButton(_ tag: Int)
}

class FishSpeciesTableViewCell: UITableViewCell {
    var cellDelegate: FishSpeciesTableViewCellDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sillyButton: UIButton!
    
    @IBAction func overviewBtnPressed(_ sender: Any) {
        let btn = sender as! UIButton
        UIView.animate(withDuration: 0.5, animations: ({
            btn.transform = btn.transform.rotated(by: CGFloat(-Double.pi ))
        }), completion: { _ in
            UIView.animate(withDuration: 0.5, animations: ({
                btn.transform = btn.transform.rotated(by: CGFloat(Double.pi ))
            }))
        })

    }
    
    @IBAction func sillyButtonPressed(_ sender: UIButton) {
        playSound()
        cellDelegate?.didClickOnCellSillyButton(sender.tag)
    }
    
    public func playSound() {
        let path = Bundle.main.path(forResource: "bubbles.wav", ofType: nil)!
        let url = URL(fileURLWithPath: path)
                
        let soundPlayer = try? AVAudioPlayer(contentsOf: url)
        soundPlayer!.play()
    }
    
    var imageUrl: String? //meh...
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func populate(speciesInfo: (name: String, scientificName: String, population: String?, imageUrl: String?)) {
        self.titleLabel.text = speciesInfo.name
        self.imageUrl = speciesInfo.imageUrl
    }
}
