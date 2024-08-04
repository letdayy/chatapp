//
//  CustomeLabel.swift
//  ChatApp
//
//  Created by leticia.dayane on 04/08/24.
//

import UIKit

class CustomeLabel: UILabel {
    init(text: String, labelFont: UIFont = .systemFont(ofSize: 14), labelColor: UIColor = .black) {
        super.init(frame: .zero)
        self.text = text
        font = labelFont
        textColor = labelColor

        textAlignment = .center
        numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
