//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by leticia.dayane on 08/07/24.
//

import UIKit

class RegisterViewController: UIViewController {
    //MARK: - Properties
    private lazy var alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedText(firstString: "Already have an account?", secondString: "Login up")
        button.setHeight(50)
        button.addTarget(self, action: #selector(handleAlreadyHaveAccountButton), for: .touchUpInside)
        return button
    }()

    private lazy var plushPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.setDimensions(height: 140, width: 140)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(handlePlushButton), for: .touchUpInside)
        return button
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .white

        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        alreadyHaveAccountButton.centerX(inView: view)

        view.addSubview(plushPhotoButton)
        plushPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 30)
    }

    @objc func handleAlreadyHaveAccountButton() {

    }

    @objc func handlePlushButton() {

    }
}
