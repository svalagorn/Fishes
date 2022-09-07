//
//  FormSheetViewController.swift
//  Fishes
//
//  Created by Erik on 2022-09-07.
//

import Foundation
import UIKit
class FormSheetViewController : UIViewController {
    private let message : String
    @IBOutlet weak var label: UILabel!
    
    init?(coder: NSCoder, message: String) {
        self.message = message
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium(),
                .large()
            ]
            presentationController.prefersGrabberVisible = true
        }
        
        super.viewDidLoad()
        label.text = message

    }
}
