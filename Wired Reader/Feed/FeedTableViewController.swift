//
//  FeedTableViewController.swift
//  Wired Reader
//
//  Created by Yura Voevodin on 29.02.2020.
//  Copyright © 2020 Yura Voevodin. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private func setup() {
        // Pull to refresh
        configureRefreshControl()

        // Load items from server
        loadData()
    }

    // MARK: - Data Source

    var dataSource = DataSource()

    /// Load items from server
    private func loadData() {

        func completion(_ error: Error?) {
            if let error = error {
                let title = NSLocalizedString("An error occurred", comment: "Alert title")
                presentAlert(title: title, message: error.localizedDescription)
            }
            tableView.reloadData()
            refreshControl?.endRefreshing()
        }

        dataSource.loadItems { error in
            completion(error)
        }
    }

    private func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        // Ok
        let ok = NSLocalizedString("OK", comment: "Alert action")
        let okAction = UIAlertAction(title: ok, style: .default, handler: nil)
        alert.addAction(okAction)

        present(alert, animated: true)
    }

    // MARK: - Pull to refresh

    private func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

    @objc func refresh() {
        loadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as FeedItemTableViewCell

        // Configure the cell
        let item = dataSource.items[indexPath.row]
        cell.update(with: item)

        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataSource.items[indexPath.row]
        performSegue(withIdentifier: "webContent", sender: item.link)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }

        switch identifier {

        case "webContent":
            let vc = segue.destination as? WebViewController
            vc?.url = sender as? URL

        default:
            break
        }
    }
}
