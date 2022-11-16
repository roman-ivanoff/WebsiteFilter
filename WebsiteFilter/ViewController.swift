//
//  ViewController.swift
//  WebsiteFilter
//
//  Created by Roman Ivanov on 16.11.2022.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - UIViews
    var linkTextField: UITextField!

    // MARK: - Properties

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupNavigatorController()
        createAndSetupLinkTextField()
    }

    // MARK: - Overrided methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    // MARK: - Actions
    @objc func backAction() {
        print("back action")
    }

    @objc func forwardAction() {
        print("forward action")
    }

    @objc func addFilterAction() {
        print("add filter")
    }

    @objc func showFilterWords() {
        print("show filter words")
    }

    // MARK: - Custom methods
    private func createAndSetupLinkTextField() {
        linkTextField = UITextField(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 44))
        linkTextField.delegate = self
        linkTextField.borderStyle = .roundedRect
        linkTextField.font = UIFont.boldSystemFont(ofSize: 15)
        linkTextField.keyboardType = .URL
        linkTextField.placeholder = "Enter URL"
        linkTextField.returnKeyType = .go
        view.addSubview(linkTextField)

        linkTextField.anchor(
            top: view.layoutMarginsGuide.topAnchor,
            leading: view.layoutMarginsGuide.leadingAnchor,
            trailing: view.layoutMarginsGuide.trailingAnchor,
            topConstant: 16
        )
    }

    private func setupNavigatorController() {
        navigationController?.isToolbarHidden = false
        title = "Website Filter"

        var items: [UIBarButtonItem] = []

        items.append(
            UIBarButtonItem(
                image: UIImage(named: "left"),
                style: .plain,
                target: self,
                action: #selector(backAction)
            )
        )

        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))

        items.append(
            UIBarButtonItem(
                image: UIImage(named: "right"),
                style: .plain,
                target: self,
                action: #selector(forwardAction)
            )
        )

        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))

        items.append(
            UIBarButtonItem(
                image: UIImage(named: "plus"),
                style: .plain,
                target: self,
                action: #selector(addFilterAction)
            )
        )

        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))

        items.append(
            UIBarButtonItem(
                image: UIImage(named: "edit"),
                style: .plain,
                target: self,
                action: #selector(showFilterWords)
            )
        )

        toolbarItems = items
    }

    private func showErrorAlert(title: String, error: String) {
        let dialogMessage = UIAlertController(
            title: title,
            message: error,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        dialogMessage.addAction(okAction)
        present(dialogMessage, animated: true)
    }
}

// MARK: - Extensions
extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, LinkModel.containsURL(string: text) {
            print("text \(text)")
        } else {
            showErrorAlert(title: "Error", error: "Please, enter correct link")
        }
        view.endEditing(true)
        return false
    }
}
