//
//  LoginGoogle.swift
//  ChatTheComplete
//
//  Created by Ahmad Mustafa on 02/02/2022.
//

import UIKit
import GoogleSignIn
import Firebase

extension LoginViewController{
    func showTextInputPrompt(withMessage message: String,
                             completionBlock: @escaping ((Bool, String?) -> Void)) {
        let prompt = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completionBlock(false, nil)
        }
        weak var weakPrompt = prompt
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            guard let text = weakPrompt?.textFields?.first?.text else { return }
            completionBlock(true, text)
        }
        prompt.addTextField(configurationHandler: nil)
        prompt.addAction(cancelAction)
        prompt.addAction(okAction)
        present(prompt, animated: true, completion: nil)
    }


    @objc func setupGoogle(){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] result, error in
            guard let self = self else { return }

            if let error = error {
                showMessage(title: "Error", message: error.localizedDescription)
                return
            }

            if let user = result?.user {
                let idToken = user.idToken?.tokenString
                let accessToken = user.accessToken.tokenString

                if idToken == nil || accessToken == nil {
                    self.showMessage(title: "Error", message: "Failed to retrieve tokens.")
                    return
                }

                let credential = GoogleAuthProvider.credential(withIDToken: idToken!,
                                                                   accessToken: accessToken)
                    // ...

                    Auth.auth().signIn(with: credential) { authResult, error in
                        if let error = error {
                            let authError = error as NSError
                            if authError.code == AuthErrorCode.secondFactorRequired.rawValue {
                                // The user is a multi-factor user. Second factor challenge is required.
                                let resolver = authError
                                    .userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
                                var displayNameString = ""
                                for tmpFactorInfo in resolver.hints {
                                    displayNameString += tmpFactorInfo.displayName ?? ""
                                    displayNameString += " "
                                }
                                self.showTextInputPrompt(
                                    withMessage: "Select factor to sign in\n\(displayNameString)",
                                    completionBlock: { userPressedOK, displayName in
                                        var selectedHint: PhoneMultiFactorInfo?
                                        for tmpFactorInfo in resolver.hints {
                                            if displayName == tmpFactorInfo.displayName {
                                                selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
                                            }
                                        }
                                        PhoneAuthProvider.provider()
                                            .verifyPhoneNumber(with: selectedHint!, uiDelegate: nil,
                                                               multiFactorSession: resolver
                                                .session) { verificationID, error in
                                                    if error != nil {
                                                        print(
                                                            "Multi factor start sign in failed. Error: \(error.debugDescription)"
                                                        )
                                                    } else {
                                                        self.showTextInputPrompt(
                                                            withMessage: "Verification code for \(selectedHint?.displayName ?? "")",
                                                            completionBlock: { userPressedOK, verificationCode in
                                                                let credential: PhoneAuthCredential? = PhoneAuthProvider.provider()
                                                                    .credential(withVerificationID: verificationID!,
                                                                                verificationCode: verificationCode!)
                                                                let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator
                                                                    .assertion(with: credential!)
                                                                resolver.resolveSignIn(with: assertion!) { authResult, error in
                                                                    if error != nil {
                                                                        print(
                                                                            "Multi factor finanlize sign in failed. Error: \(error.debugDescription)"
                                                                        )
                                                                    } else {
                                                                        self.navigationController?.popViewController(animated: true)
                                                                    }
                                                                }
                                                            }
                                                        )
                                                    }
                                                }
                                    }
                                )
                            } else {
                                self.showMessage(title: "Error", message: error.localizedDescription)
                                return
                            }
                            // ...
                            return
                        }
                        // User is signed in
                        // ...
                        self.updateUserInfo()
                    }
                }
            }
        }
    }

//MARK: Login user info
extension LoginViewController {
    func updateUserInfo() {
        guard let user = Auth.auth().currentUser else { return }

        guard let email = user.email,
              let fullname = user.displayName,
              let photoURL = user.photoURL else { return }

        let uid = user.uid
        let username = fullname.replacingOccurrences(of: " ", with: "").lowercased()

        getImage(withImageURL: photoURL) { image in
            let credential = AuthCredentialEmail(email: email, uid: uid, username: username, fullname: fullname, profileImage: image)

            AuthServices.registerWithGoogle(credential: credential) { error in
                if let error = error {
                    self.showMessage(title: "Error", message: error.localizedDescription)
                    return
                }

                print("Succ create to firestore")
            }
        }
    }
}
