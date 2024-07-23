//
//  LoginViewController.swift
//  ChatApp
//
//  Created by leticia.dayane on 08/07/24.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    //MARK: - Properties
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "HEY, WELCOME"
        label.font = .boldSystemFont(ofSize: 20)
        label.tintColor = .black
        return label
    }()

    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "profile")
        iv.contentMode = .scaleAspectFit
        iv.setDimensions(height: 50, width: 50)
        return iv
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .white

        view.addSubview(welcomeLabel)
        welcomeLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        welcomeLabel.centerX(inView: view)

        view.addSubview(profileImageView)
        profileImageView.anchor(top: welcomeLabel.bottomAnchor, paddingTop: 20)
        profileImageView.centerX(inView: view)
    }
}
