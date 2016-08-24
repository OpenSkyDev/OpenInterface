//
//  BaseFetchedResultsTableViewController.swift
//  OpenInterface
//
//  Created by Skylar Schipper on 8/23/16.
//  Copyright © 2016 OpenSky, LLC. All rights reserved.
//

import UIKit
import CoreData

open class BaseFetchedResultsTableViewController<ResultType: NSFetchRequestResult> : BaseTableViewController, NSFetchedResultsControllerDelegate {
    private var _fetchedResultsController : NSFetchedResultsController<ResultType>? = nil

    var fetchedResultsController: NSFetchedResultsController<ResultType> {
        if let f = _fetchedResultsController {
            return f
        }
        let fetch = self.fetchRequestForFetchedResultsController()
        let context = self.contextForFetchedResultsController()
        let section = self.sectionNameKeyPathForFetchedResultsController()
        let cache = self.cacheNameForFetchedResultsController()
        let controller = NSFetchedResultsController(fetchRequest: fetch, managedObjectContext: context, sectionNameKeyPath: section, cacheName: cache)
        controller.delegate = self
        _fetchedResultsController = controller
        return controller
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Data Loaders
    func performFetch() {
        do {
            try self.fetchedResultsController.performFetch()
        } catch let e {
            self.handleFetchError(e)
        }
    }

    open override func reloadTableView() {
        self.performFetch()
        super.reloadTableView()
    }

    func setNeedsNewFetchedResultsController() {
        _fetchedResultsController = nil
    }

    open func contextForFetchedResultsController() -> NSManagedObjectContext {
        fatalError("Must override \(#function) in subclass")
    }

    open func fetchRequestForFetchedResultsController() -> NSFetchRequest<ResultType> {
        fatalError("Must override \(#function) in subclass")
    }

    open func sectionNameKeyPathForFetchedResultsController() -> String? {
        return nil
    }

    open func cacheNameForFetchedResultsController() -> String? {
        return nil
    }

    open func handleFetchError(_ error: Error) {
        print("Fetch Failed: \(error)")
    }

    // MARK: - Data Source
    open override func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }

    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.fetchedResultsController.sections?[section] else {
            return 0
        }
        return section.numberOfObjects
    }

    open func configure<T: UITableViewCell>(cell: T, forRowAtIndexPath indexPath: IndexPath) {
        let object = self.fetchedResultsController.object(at: indexPath)
        self.configure(cell: cell, withObject: object, atIndexPath: indexPath)
    }

    open func configure<T : UITableViewCell>(cell: T, withObject object: ResultType, atIndexPath indexPath: IndexPath) {

    }
}
