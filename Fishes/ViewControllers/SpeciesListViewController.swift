//
//  ViewController.swift
//  Fishes
//
//  Created by Devs on 2022-09-07.
//

import UIKit

class SpeciesListViewController: UIViewController, UpdateDelegate {
    private let viewModel : SpeciesListViewModel
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView! {
      didSet {
        loadingView.layer.cornerRadius = 8
      }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    init?(coder: NSCoder, viewModel: SpeciesListViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
        self.viewModel.updateDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didUpdate(with state: ViewState) { //blir trevligt reaktivt med delegaten tycker jag (påminner om bloc pattern som jag kör i Flutter)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch state {
            case .initial:
                break
            case .loaded:
                self.tableView.reloadData()
                self.stopLoading()
            case .loading:
                self.startLoading()
            case .error(let error):
                let alertController = UIAlertController(
                    title: "Error",
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )

                let confirmAction = UIAlertAction(
                    title: "Try again", style: .default) { (action) in
                    self.viewModel.loadSpeciesFromAPI()
                }
                let cancelAction = UIAlertAction(
                    title: "Cancel", style: .destructive) { (action) in
                        alertController.dismiss(animated: true)
                }
                alertController.addAction(cancelAction)
                alertController.addAction(confirmAction)
                
                
                self.present(alertController, animated: true, completion: nil)
                self.stopLoading()
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.registerTableViewCells()
        self.viewModel.loadSpeciesFromAPI()
    }

    private func startLoading() {
        activityIndicator.startAnimating()
        loadingView.isHidden = false
    }

    private func stopLoading() {
        activityIndicator.stopAnimating()
        loadingView.isHidden = true
    }

}

extension SpeciesListViewController: UITableViewDelegate, UITableViewDataSource, FishSpeciesTableViewCellDelegate {
    
    func didClickOnCellSillyButton(_ tag: Int) {
        let species = viewModel.allSpecies[tag]
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
        let formSheetViewController = storyboard.instantiateViewController(identifier: "formSheet", creator: { coder -> FormSheetViewController? in
            FormSheetViewController(coder: coder, message: species.name)
        })
        
        present(formSheetViewController, animated: true)
    }
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "FishSpeciesTableViewCell",
                                  bundle: nil)
        self.tableView.register(textFieldCell,
                                forCellReuseIdentifier: "FishSpeciesTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let customCell = tableView.dequeueReusableCell(withIdentifier: "FishSpeciesTableViewCell") as? FishSpeciesTableViewCell {
            customCell.populate(speciesInfo: viewModel.getSpeciesInfo(for: indexPath))
            customCell.cellDelegate = self
            customCell.sillyButton.tag = indexPath.row
            return customCell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tappedSpecies = viewModel.allSpecies[indexPath.row]
        viewModel.goToDetailsView(tappedSpecies: tappedSpecies)
    }
}
