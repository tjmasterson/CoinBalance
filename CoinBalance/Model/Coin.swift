//
//  Coin.swift
//  CoinBalance
//
//  Created by Taylor Masterson on 2/3/18.
//  Copyright © 2018 Taylor Masterson. All rights reserved.
//

import UIKit
import CoreData

class Coin: NSManagedObject {

    class func findOrCreateCoin(matching coinData: CoinData, in context: NSManagedObjectContext) throws -> Coin {
        let request: NSFetchRequest<Coin> = Coin.fetchRequest()
        request.predicate = NSPredicate(format: "coinID = %@", coinData.coinID)
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "Coin.findOrCreateCoin -- database inconsistency")
                return matches[0]
            }
        } catch {
            throw error
        }
        
        let coin = Coin(context: context)
        return coin
    }
    
    class func saveCoin(matching coinData: CoinData, in context: NSManagedObjectContext) throws -> Coin {
        do {
            let coin = try self.findOrCreateCoin(matching: coinData, in: context)
            coin.coinID = coinData.coinID
            coin.name = coinData.name
            coin.symbol = coinData.symbol
            coin.rank =  Int64(coinData.rank)!
            coin.priceUSD = Double(coinData.priceUSD)!
            coin.priceBTC = Double(coinData.priceBTC)!
            coin.volumeLast24Hr = Double(coinData.volumeLast24Hr)!
            coin.marketCapUSD = Double(coinData.marketCapUSD)!
            coin.availableSupply = Double(coinData.availableSupply)!
            coin.totalSupply = Double(coinData.totalSupply)!
            coin.maxSupply = Double(coinData.maxSupply ?? "0.0")!
            coin.percentChange1Hr = Double(coinData.percentChange1Hr ?? "0.0")!
            coin.percentChange24Hr = Double(coinData.percentChange24Hr ?? "0.0")!
            coin.percentChange7D = Double(coinData.percentChange7D ?? "0.0")!
            coin.lastUpdated = NSDate(timeIntervalSince1970: TimeInterval(coinData.lastUpdated)!) as Date
            return coin
        } catch {
            throw error
        }
    }
}
