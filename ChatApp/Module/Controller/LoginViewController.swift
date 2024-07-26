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

    private let emailTF: UITextField = {
        let tf = UITextField()
        tf.tintColor = .black
        tf.setHeight(50)
        tf.placeholder = "Email"
        tf.backgroundColor = .lightGray
        return tf
    }()


    private let passwordTF: UITextField = {
        let tf = UITextField()
        tf.tintColor = .black
        tf.setHeight(50)
        tf.placeholder = "Password"
        tf.backgroundColor = .lightGray
        return tf
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.setHeight(50)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 19)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()

    private lazy var forgetPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forget your password? Get help signing in", for: .normal)
        button.tintColor = .black
        button.setHeight(20)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleForgetPassword), for: .touchUpInside)
        return button
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't have an account? Sign up", for: .normal)
        button.tintColor = .black
        button.setHeight(20)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleSignUpButton), for: .touchUpInside)
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

        view.addSubview(welcomeLabel)
        welcomeLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        welcomeLabel.centerX(inView: view)

        view.addSubview(profileImageView)
        profileImageView.anchor(top: welcomeLabel.bottomAnchor, paddingTop: 20)
        profileImageView.centerX(inView: view)

        let stackView = UIStackView(arrangedSubviews: [emailTF, passwordTF, loginButton, forgetPasswordButton])
        stackView.axis = .vertical
        stackView.spacing = 20

        view.addSubview(stackView)
        stackView.anchor(top: profileImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 30, paddingRight: 30)

        view.addSubview(signUpButton)
        signUpButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        signUpButton.centerX(inView: view)
    }

    @objc func handleLogin() {
        print("Login!")
    }

    @objc func handleForgetPassword() {

    }

    @objc func handleSignUpButton() {

    }
}
