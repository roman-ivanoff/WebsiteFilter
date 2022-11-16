//
//  UIView+Configuration.swift
//  WebsiteFilter
//
//  Created by Roman Ivanov on 16.11.2022.
//

import UIKit

extension UIView {
    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        leading: NSLayoutXAxisAnchor? = nil,
        trailing: NSLayoutXAxisAnchor? = nil,
//        view: UIView,
        topConstant: CGFloat = 0,
        bottomConstant: CGFloat = 0,
        leadingConstant: CGFloat = 0,
        trailingConstant: CGFloat = 0,
        size: CGSize = .zero
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []

        if let top = top {
            constraints.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }

        if let bottom = bottom {
            constraints.append(bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant))
        }

        if let leading = leading {
            constraints.append(leadingAnchor.constraint(equalTo: leading, constant: leadingConstant))
        }

        if let trailing = trailing {
            constraints.append(trailingAnchor.constraint(equalTo: trailing, constant: trailingConstant))
        }

        if size.width != 0 {
            constraints.append(widthAnchor.constraint(equalToConstant: size.width))
        }

        if size.height != 0 {
            constraints.append(heightAnchor.constraint(equalToConstant: size.height))
        }

        NSLayoutConstraint.activate(constraints)
    }
}

