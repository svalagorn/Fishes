//
//  AsyncImageLoader.swift
//  Fishes
//
//  Created by Erik on 2022-09-07.
//

import UIKit

extension UIImageView { //Lite lokal cachning hade varit p[ sin plats
    func loadRemoteImage(_ urlString: String, placeHolder: UIImage?) {
        self.image = UIImage(named: "loading")

        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                DispatchQueue.main.async {
                    if error != nil {
                        self.image = placeHolder
                    }
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            self.image = downloadedImage
                        } else {
                            self.image = UIImage(named: "notfound")
                        }
                    }
                }
            }).resume()
        }
    }
}
