//
//  CoinData.swift
//  CoinBalance
//
//  Created by Taylor Masterson on 2/1/18.
//  Copyright © 2018 Taylor Masterson. All rights reserved.
//

import Foundation


public struct CoinData: Codable {
    let coinID: String
    let name: String
    let symbol: String
    let rank: String
    let priceUSD: String
    let priceBTC: String
    let volumeLast24Hr: String
    let marketCapUSD: String
    let availableSupply: String
    let totalSupply: String
    let maxSupply: String?
    let percentChange1Hr: String?
    let percentChange24Hr: String?
    let percentChange7D: String?
    let lastUpdated: String

    enum CodingKeys : String, CodingKey {
        case coinID = "id"
        case name
        case symbol
        case rank
        case priceUSD = "price_usd"
        case priceBTC = "price_btc"
        case volumeLast24Hr = "24h_volume_usd"
        case marketCapUSD = "market_cap_usd"
        case availableSupply = "available_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case percentChange1Hr = "percent_change_1h"
        case percentChange24Hr = "percent_change_24h"
        case percentChange7D = "percent_change_7d"
        case lastUpdated = "last_updated"
    }
}
