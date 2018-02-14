//
//  Transaction.swift
//  CoinBalance
//
//  Created by Taylor Masterson on 2/3/18.
//  Copyright © 2018 Taylor Masterson. All rights reserved.
//

import UIKit
import CoreData

class Transaction: NSManagedObject {
    
    class func findOrCreateTransaction(matching transactionID: Int?, in context: NSManagedObjectContext) throws -> Transaction {
        
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        request.predicate = NSPredicate(format: "objectID == %@", transactionID!)
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "Transaction.updateTranasaction -- database inconsistency")
                return matches[0]
            }
        } catch {
            throw error
        }
        
        let transaction = Transaction(context: context)
        return transaction
    }

}
