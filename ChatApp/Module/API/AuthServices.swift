//
//  AuthServices.swift
//  ChatApp
//
//  Created by leticia.dayane on 17/08/24.
//

import UIKit
import FirebaseFirestoreInternal

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
        Firestore.firestore().collection("")
    }
}
