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
        button.blackButton(buttonText: "Sign up")
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()

    private var profileImage: UIImage?

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
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }

    @objc func handleSignUp() {
        guard let email = emailTF.text else { return }
        guard let password = emailTF.text else { return }
        guard let username = emailTF.text else { return }
        guard let fullname = emailTF.text else { return }
        guard let profileImage = profileImage else { return }

        let credential = AuthCredential(email: email, password: password, username: username, fullname: fullname, profileImage: profileImage)
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


extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }

        self.profileImage = selectedImage

        plushPhotoButton.layer.cornerRadius = plushPhotoButton.frame.width / 2
        plushPhotoButton.layer.masksToBounds = true
        plushPhotoButton.layer.borderColor = UIColor.black.cgColor
        plushPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true)
    }
}
