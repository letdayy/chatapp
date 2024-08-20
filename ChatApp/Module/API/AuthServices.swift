//
//  AuthServices.swift
//  ChatApp
//
//  Created by leticia.dayane on 17/08/24.
//

import UIKit
import FirebaseAuth

struct AuthCredential {
    let email: String
    let password: String
    let username: String
    let fullname: String
    let profileImage: UIImage
}

struct AuthServices {
    static func loginUser() {

    }

    static func registerUser(credential: AuthCredential) {
        FileUploader.uploadImage(image: credential.profileImage) { imageURL in
            print("ImageURL: \(imageURL)")
        }
    }
}
