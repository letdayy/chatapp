//
//  VC.swift
//  ChatApp
//
//  Created by leticia.dayane on 25/08/24.
//

import UIKit
import JGProgressHUD
import SDWebImage

extension UIViewController {
    static let hud = JGProgressHUD(style: .dark)

    func showLoader(_ show: Bool) {
        view.endEditing(true)

        if show {
            UIViewController.hud.show(in: view)
        } else {
            UIViewController.hud.dismiss()
        }
    }

    func showMessage(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            completion?()
        }))

        present(alert, animated: true)
    }

    func getImage(withImageURL imageURL: URL, completion: @escaping(UIImage) -> Void){
        SDWebImageManager.shared.loadImage(with: imageURL, options: .continueInBackground, progress: nil) {image, data, error, cashType, finished, url  in
            if let error = error {
                self.showMessage(title: "Error", message: error.localizedDescription)
                return
            }

            guard let image = image else { return }
            completion(image)
        }
    }
}
