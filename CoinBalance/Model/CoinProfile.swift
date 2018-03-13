//
//  CoinProfile.swift
//  CoinBalance
//
//  Created by Taylor Masterson on 2/11/18.
//  Copyright © 2018 Taylor Masterson. All rights reserved.
//

import UIKit
import CoreData

class CoinProfile: NSManagedObject {

    class func findOrCreateCoinProfile(for coin: Coin, in context: NSManagedObjectContext) throws -> CoinProfile {
        
        let request: NSFetchRequest<CoinProfile> = CoinProfile.fetchRequest()
        request.predicate = NSPredicate(format: "coin = %@", coin)
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "CoinProfile.findOrCreateCoinProfile -- database inconsistency")
                return matches[0]
            }
        } catch {
            throw error
        }
        
        let coinProfile = CoinProfile(context: context)
        coinProfile.coin = coin
        return coinProfile
    }
    
}
