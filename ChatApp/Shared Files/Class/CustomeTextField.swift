//
//  CustomeTextField.swift
//  ChatApp
//
//  Created by leticia.dayane on 31/07/24.
//

import UIKit

class CustomeTextField: UITextField {
    init(placehouder: String, keyboardType: UIKeyboardType = .default, isSecure: Bool = false) {
        super.init(frame: .zero)

        borderStyle = .none
        textColor = .black
        keyboardAppearance = .light
        clearButtonMode = .whileEditing
        backgroundColor = #colorLiteral(red: 0.965680182, green: 0.965680182, blue: 0.965680182, alpha: 1)
        setHeight(50)

        self.keyboardType = keyboardType
        isSecureTextEntry = isSecure
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
