//
//  CoinPriceTableViewCell.swift
//  CoinBalance
//
//  Created by Taylor Masterson on 2/3/18.
//  Copyright © 2018 Taylor Masterson. All rights reserved.
//

import UIKit

class CoinPriceTableViewCell: UITableViewCell {

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var percentChangeLabel: UILabel!
    
    var coin: Coin? {
        didSet {
            updateUI()
        }
    }

    private func updateUI() {
        
        rankLabel?.text = String(describing: (coin?.rank)!)
        nameLabel?.text = coin?.name
        priceLabel.text = String(describing: (coin?.priceUSD)!)
        percentChangeLabel?.text = String(describing: (coin?.percentChange24Hr)!)
    }
}
