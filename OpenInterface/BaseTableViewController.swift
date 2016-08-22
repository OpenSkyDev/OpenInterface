//
//  BaseTableViewController.swift
//  OpenInterface
//
//  Created by Skylar Schipper on 8/21/16.
//  Copyright © 2016 OpenSky, LLC. All rights reserved.
//

import UIKit

public protocol TableViewSetup : class {
    // Add constraints
    func installConstrants(forTableView tableView: UITableView, inView view: UIView)

    // Finish setup and register classes
    func finishSetup(forTableView tableView: UITableView)

    // Get identifier
    func identifier(inTableView tableView: UITableView, forCellAtIndexPath indexPath: IndexPath) -> String

    // Configure cell
    func configure<T: UITableViewCell>(cell: T, forRowAtIndexPath indexPath: IndexPath)
}

public class BaseTableViewController: BaseViewController, TableViewSetup {
    static let defaultCellIdentifier = "BaseTableViewControllerDefaultCell"

    var tableView: UITableView {
        let tv = UITableView.newAutoLayoutView()
        self.view.addSubview(tv)
        self.installConstrants(forTableView: tv, inView: self.view)
        return tv
    }

    // MARK: - View Lifecycle
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.reloadTableView()
    }


    // MARK: - Data Management
    func reloadTableView() {
        self.tableView.reloadData()
    }
}

extension BaseTableViewController : UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = self.identifier(inTableView: tableView, forCellAtIndexPath: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        self.configure(cell: cell, forRowAtIndexPath: indexPath)
        return cell
    }
}

extension TableViewSetup {
    public func installConstrants(forTableView tableView: UITableView, inView view: UIView) {
        view.addConstraints(NSLayoutConstraint.offset(inSuperViewForView: tableView, offset: 0.0, edges: [.all]))
    }

    public func finishSetup(forTableView tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: BaseTableViewController.defaultCellIdentifier)
    }

    public func identifier(inTableView tableView: UITableView, forCellAtIndexPath indexPath: IndexPath) -> String {
        return BaseTableViewController.defaultCellIdentifier
    }

    public func configure<T: UITableViewCell>(cell: T, forRowAtIndexPath indexPath: IndexPath) {

    }
}
