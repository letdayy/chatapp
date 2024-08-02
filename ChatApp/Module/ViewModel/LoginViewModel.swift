//
//  LoginViewModel.swift
//  ChatApp
//
//  Created by leticia.dayane on 31/07/24.
//

import Foundation
import UIKit

struct LoginViewModel {
    var email: String?
    var password: String?

    var formIsFaild: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }

    var backgroundColor: UIColor {
        return formIsFaild ? (UIColor.black) : (UIColor.black.withAlphaComponent(0.5))
    }

    var buttonTitleColor: UIColor {
        return formIsFaild ? (UIColor.white) : (UIColor(white: 1, alpha: 0.7))
    }
}

struct RegisterViewModel {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?

    var formIsFaild: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false && username?.isEmpty == false
    }

    var backgroundColor: UIColor {
        return formIsFaild ? (UIColor.black) : (UIColor.black.withAlphaComponent(0.5))
    }

    var buttonTitleColor: UIColor {
        return formIsFaild ? (UIColor.white) : (UIColor(white: 1, alpha: 0.7))
    }
}
