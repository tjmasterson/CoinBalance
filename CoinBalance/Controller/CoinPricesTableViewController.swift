//
//  CoinPricesTableViewController.swift
//  CoinBalance
//
//  Created by Taylor Masterson on 2/3/18.
//  Copyright © 2018 Taylor Masterson. All rights reserved.
//

import UIKit
import CoreData 

class CoinPricesTableViewController: FetchedResultsTableViewController {

    var context: NSManagedObjectContext? = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext {
        didSet {
            updateUI()
        }
    }
    var fetchedResultsController: NSFetchedResultsController<Coin>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupRefreshController()
        printDatabaseStatistics()
        updateUI()
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func setupRefreshController() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Updating...")
    }
    
    private func updateUI() {
        
        if let context = context {
            let request: NSFetchRequest<Coin> = Coin.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(
                key: "rank",
                ascending: true
//                selector: #selector(NSString.localizedCaseInsensitiveCompare(_:))
            )]
            fetchedResultsController = NSFetchedResultsController<Coin>(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            fetchedResultsController?.delegate = self
            try? fetchedResultsController?.performFetch()
            tableView.reloadData()
        }
    }
    
    private var lastCoinRequest: Request?
    
    private func coinRequest() -> Request? {
        return Request()
    }
    
    private func fetchCoinPrices()  {
        if let request = lastCoinRequest ?? coinRequest() {
            lastCoinRequest = request
            request.fetchCoins { [weak self] coins in
                DispatchQueue.main.async {
                    if request == self?.lastCoinRequest {
                        self?.updateDatabase(coins)
                    }
                }
            }
        }
    }
    
    func updateDatabase(_ coins: [CoinData]) {
        if let context = context {
            for coin in coins {
                do {
                    _ = try Coin.saveCoin(matching: coin, in: context)
                } catch {
                    print(error)
                }
            }
            do {
                try context.save()
            } catch {
                print(error)
            }
            self.updateUI()
            self.refreshControl?.endRefreshing()
            self.printDatabaseStatistics()
        }
    }
    
    private func printDatabaseStatistics() {
        if let context = context {
            context.perform {
                if Thread.isMainThread {
                    print("on main thread")
                } else {
                    print("off main thread")
                }

                if let coinCount = try? context.count(for: Coin.fetchRequest()) {
                    print("\(coinCount) coins saved")
                }
            }
        }
    }
    
    @objc private func refresh(_ sender: Any) {
        fetchCoinPrices()
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CoinToCoinProfile" {
            if let viewController = segue.destination as? CoinProfileViewController {
                let cellIndex = tableView.indexPathForSelectedRow!
                let cell = tableView.cellForRow(at: cellIndex) as! CoinPriceTableViewCell
                viewController.coin = cell.coin
                viewController.context = context
            }
        }
    }
 

}

extension CoinPricesTableViewController {
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.fetchedObjects?.count ?? 0
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinPriceTableViewCell", for: indexPath)
        let coin = fetchedResultsController?.object(at: indexPath)
        
        if let coinCell = cell as? CoinPriceTableViewCell {
            coinCell.coin = coin
        }
        
        return cell
     }
    
}
