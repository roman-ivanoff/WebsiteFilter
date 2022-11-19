//
//  FilterWordsViewController.swift
//  WebsiteFilter
//
//  Created by Roman Ivanov on 18.11.2022.
//

import UIKit

class FilterWordsViewController: UIViewController {
    // MARK: - UIViews
    var tableView: UITableView!

    // MARK: - Properties
    let cellId = "Cell"
    var filterWords: [String]

    // MARK: - Initializers
    init(filterWords: [String]) {
        self.filterWords = filterWords
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with filterWords")
    }

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }

        navigationController?.isToolbarHidden = true
        navigationItem.title = NSLocalizedString("filter_words", comment: "")
        navigationController?.delegate = self

        createAndSetupTableView()
        registerCell(for: tableView, id: cellId)
        addSubviewsToView()
        setAnchors()
    }

    // MARK: - Custom methods
    private func createAndSetupTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.accessibilityIdentifier = "filterWordsTableView"
    }

    private func addSubviewsToView() {
        view.addSubview(tableView)
    }

    private func setAnchors() {
        tableView.anchor(
            top: view.layoutMarginsGuide.topAnchor,
            bottom: view.layoutMarginsGuide.bottomAnchor,
            leading: view.layoutMarginsGuide.leadingAnchor,
            trailing: view.layoutMarginsGuide.trailingAnchor,
            leadingConstant: -8,
            trailingConstant: 8
        )
    }

    private func registerCell(for tableView: UITableView, id: String) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: id)
    }
}

// MARK: - UITableViewDelegate
extension FilterWordsViewController: UITableViewDelegate {

}

// MARK: - UITableViewDataSource
extension FilterWordsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filterWords.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        cell.textLabel?.text = filterWords[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            filterWords.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - UINavigationControllerDelegate
extension FilterWordsViewController: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        willShow viewController: UIViewController,
        animated: Bool
    ) {
        (viewController as? ViewController)?.navigationController?.isToolbarHidden = false
        (viewController as? ViewController)?.filterWords = filterWords
    }
}
