//
//  LinkTextField.swift
//  WebsiteFilter
//
//  Created by Roman Ivanov on 17.11.2022.
//

import UIKit

class LinkTextField: UITextField {

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    private func setup() {
        borderStyle = .roundedRect
        font = UIFont.boldSystemFont(ofSize: 15)
        keyboardType = .URL
        placeholder = NSLocalizedString("enter_url", comment: "")
        returnKeyType = .go
    }
}
