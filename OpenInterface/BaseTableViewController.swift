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

open class BaseTableViewController: BaseViewController, TableViewSetup, UITableViewDelegate, UITableViewDataSource {
    static let defaultCellIdentifier = "BaseTableViewControllerDefaultCell"

    lazy var tableView: UITableView = {
        let tv = UITableView.newAutoLayoutView()
        self.view.addSubview(tv)
        self.installConstrants(forTableView: tv, inView: self.view)
        self._finishTableViewSetup(tv)
        return tv
    }()

    // MARK: - View Lifecycle
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.reloadTableView()
    }


    // MARK: - Data Management
    open func reloadTableView() {
        self.tableView.reloadData()
    }

    // MARK: - Setup
    private final func _finishTableViewSetup(_ tv: UITableView) {
        tv.register(UITableViewCell.self, forCellReuseIdentifier: BaseTableViewController.defaultCellIdentifier)
        tv.dataSource = self
        tv.delegate = self
        self.finishSetup(forTableView: tv)
    }

    // MARK: - Setup
    open func installConstrants(forTableView tableView: UITableView, inView view: UIView) {
        view.addConstraints(NSLayoutConstraint.offset(inSuperViewForView: tableView, offset: 0.0, edges: [.all]))
    }

    open func finishSetup(forTableView tableView: UITableView) {

    }

    open func identifier(inTableView tableView: UITableView, forCellAtIndexPath indexPath: IndexPath) -> String {
        return BaseTableViewController.defaultCellIdentifier
    }

    open func configure<T: UITableViewCell>(cell: T, forRowAtIndexPath indexPath: IndexPath) {
        
    }

    // MARK: - Table Data Source
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = self.identifier(inTableView: tableView, forCellAtIndexPath: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        self.configure(cell: cell, forRowAtIndexPath: indexPath)
        return cell
    }
}
