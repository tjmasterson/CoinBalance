//
//  CoinInfoTableViewController.swift
//  CoinBalance
//
//  Created by Taylor Masterson on 2/24/18.
//  Copyright © 2018 Taylor Masterson. All rights reserved.
//

import UIKit

class CoinInfoTableViewController: UITableViewController {
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var priceUSDLabel: UILabel!
    @IBOutlet weak var marketCapUSDLabel: UILabel!
    @IBOutlet weak var volumeLast24hrLabel: UILabel!
    @IBOutlet weak var availableSupplyLabel: UILabel!
    @IBOutlet weak var totalSupplyLabel: UILabel!
    @IBOutlet weak var maxSupplyLabel: UILabel!
    @IBOutlet weak var percentChange1HrLabel: UILabel!
    @IBOutlet weak var percentChange24HrLabel: UILabel!
    @IBOutlet weak var percentChange7DLabel: UILabel!
    
    var coin: Coin? {
        didSet {
            updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        tableView.isScrollEnabled = true
    }

    private func updateUI() {
        rankLabel?.text = String(describing: (coin?.rank)!)
        priceUSDLabel?.text = String(describing: (coin?.priceUSD)!)
        marketCapUSDLabel?.text = String(describing: (coin?.marketCapUSD)!)
        volumeLast24hrLabel?.text = String(describing: (coin?.volumeLast24Hr)!)
        availableSupplyLabel?.text = String(describing: (coin?.availableSupply)!)
        totalSupplyLabel?.text = String(describing: (coin?.totalSupply)!)
        maxSupplyLabel?.text = String(describing: (coin?.maxSupply)!)
        percentChange1HrLabel?.text = String(describing: (coin?.percentChange1Hr)!)
        percentChange24HrLabel?.text = String(describing: (coin?.percentChange24Hr)!)
        percentChange7DLabel?.text = String(describing: (coin?.percentChange7D)!)
    }

}
