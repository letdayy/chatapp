//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by leticia.dayane on 08/07/24.
//

import UIKit

class RegisterViewController: UIViewController {
    //MARK: - Properties
    var viewModel = RegisterViewModel()

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

    private var emailTF = CustomeTextField(placeholder: "Email", keyboardType: .emailAddress)
    private var passwordTF = CustomeTextField(placeholder: "Password", isSecure: true)
    private var fullnameTF = CustomeTextField(placeholder: "Fullname")
    private var usernameTF = CustomeTextField(placeholder: "Username")

    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        button.setTitleColor(UIColor(white: 1, alpha: 0.7), for: .normal)
        button.setHeight(50)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 19)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTextField()
    }
    
    //MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .white

        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        alreadyHaveAccountButton.centerX(inView: view)

        view.addSubview(plushPhotoButton)
        plushPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 30)

        let stackView = UIStackView(arrangedSubviews: [emailTF, passwordTF, fullnameTF, usernameTF, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 20

        view.addSubview(stackView)
        stackView.anchor(top: plushPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 30, paddingRight: 30)
    }

    private func configureTextField() {
        emailTF.addTarget(self, action: #selector(handleTextField(sender:)), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(handleTextField(sender:)), for: .editingChanged)
        fullnameTF.addTarget(self, action: #selector(handleTextField(sender:)), for: .editingChanged)
        usernameTF.addTarget(self, action: #selector(handleTextField(sender:)), for: .editingChanged)
    }

    @objc func handleAlreadyHaveAccountButton() {
        navigationController?.popViewController(animated: true)
    }

    @objc func handlePlushButton() {

    }

    @objc func handleSignUp() {

    }

    @objc func handleTextField(sender: UITextField) {
        if sender == emailTF {
            viewModel.email = sender.text
        } else if sender == passwordTF {
            viewModel.password = sender.text
        } else if sender == fullnameTF {
            viewModel.fullname = sender.text
        } else {
            viewModel.username = sender.text
        }

        updateForm()
    }

    private func updateForm() {
        signUpButton.isEnabled = viewModel.formIsFaild
        signUpButton.backgroundColor = viewModel.backgroundColor
        signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
    }
}
