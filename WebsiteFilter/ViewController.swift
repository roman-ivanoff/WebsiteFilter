//
//  ViewController.swift
//  WebsiteFilter
//
//  Created by Roman Ivanov on 16.11.2022.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - UIViews
    var linkTextField: LinkTextField!

    // MARK: - Properties
    var filterWords: [String] = []

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        if #available(iOS 13, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }

        setupNavigatorController()
        createAndSetupLinkTextField()
        addSubviewsToView()
        setAnchors()
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
        showTextFieldAlert()
    }

    @objc func showFilterWords() {
        print(filterWords)
    }

    // MARK: - Custom methods
    private func createAndSetupLinkTextField() {
        linkTextField = LinkTextField(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 44))
        linkTextField.delegate = self
    }

    private func addSubviewsToView() {
        view.addSubview(linkTextField)
    }

    private func setAnchors() {
        linkTextField.anchor(
            top: view.layoutMarginsGuide.topAnchor,
            leading: view.layoutMarginsGuide.leadingAnchor,
            trailing: view.layoutMarginsGuide.trailingAnchor,
            topConstant: 16
        )
    }

    private func setupNavigatorController() {
        navigationController?.isToolbarHidden = false
        title = NSLocalizedString("website_filter", comment: "")

        if #available(iOS 13, *) {
            navigationController?.toolbar.tintColor = .systemIndigo
        } else {
            navigationController?.toolbar.tintColor = .black
        }

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

    private func showTextFieldAlert() {
        let alertController = UIAlertController(
            title: NSLocalizedString("add_filter_word", comment: ""),
            message: "", preferredStyle: .alert
        )
        alertController.addTextField { (textField: UITextField!) -> Void in
            textField.placeholder = NSLocalizedString("enter_filter_word", comment: "")
        }

        let addAction = UIAlertAction(
            title: NSLocalizedString("add", comment: ""),
            style: .default
        ) { [weak self] _ in
            guard let self else {
                return
            }
            let textField = alertController.textFields
            if let word = textField?[0].text {
                self.addFilterWord(word)
            }
        }

        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel)

        alertController.addAction(addAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }

    private func addFilterWord(_ word: String?) {
        if let word = word {
            filterWords.append(word)
        }
    }
}

// MARK: - Extensions
extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, LinkModel.containsURL(string: text) {
            print("text \(text)")
        } else {
            showErrorAlert(
                title: NSLocalizedString("error", comment: ""),
                error: NSLocalizedString("enter_correct_link", comment: "")
            )
        }
        view.endEditing(true)
        return false
    }
}
