//
//  TransactionFrom.swift
//  CoinBalance
//
//  Created by Taylor Masterson on 2/14/18.
//  Copyright © 2018 Taylor Masterson. All rights reserved.
//

import Foundation
import UIKit


class TransactionForm: Form {
    
    var username: String?
    var mail: String?
    var phoneNumber: String?
    
    override init() {
        super.init()
        self.configureItems()
    }
    
    /// Prepare all form Items ViewModels for the DirectStudioForm
    private func configureItems() {
        
        // Coin Price in USD
        let coinPriceInUSD = FormItem(placeholder: "Enter Price", label: "Price in USD")
        coinPriceInUSD.uiProperties.cellType = TransactionFormItemCellType.textFieldWithLabel as AnyObject
        coinPriceInUSD.value = self.username
        coinPriceInUSD.valueCompletion = { [weak self, weak coinPriceInUSD] value in
            self?.username = value
            coinPriceInUSD?.value = value
        }
        
        
        // Date Of Transaction
        let dateOfTransaction = FormItem(placeholder: "Enter Date", label: "Date")
        dateOfTransaction.uiProperties.cellType = TransactionFormItemCellType.dateTypeTextFieldWithLabel as AnyObject
//        dateOfTransaction.uiProperties.keyboardType = .phonePad
        dateOfTransaction.uiProperties.dateStyle = DateFormatter.Style.short
        dateOfTransaction.uiProperties.timeStyle = DateFormatter.Style.none
        dateOfTransaction.value = self.phoneNumber
        dateOfTransaction.valueCompletion = { [weak self, weak dateOfTransaction] value in
            self?.phoneNumber = value
            dateOfTransaction?.value = value
        }
        
        self.formItems = [coinPriceInUSD, dateOfTransaction]
    }
    
    // UI Cell Type to be displayed
    enum TransactionFormItemCellType {
        case textFieldWithLabel
        case dateTypeTextFieldWithLabel
        
        
        // Correctly dequeue the UITableViewCell according to the current cell type
        func dequeueCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
            
            let cell: UITableViewCell
            
            switch self {
                
            case .textFieldWithLabel:
                cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TransactionTextFieldTableViewCell.self), for: indexPath)
                
            case .dateTypeTextFieldWithLabel:
                cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TransactionDateTypeTextFieldTableViewCell.self), for: indexPath)
            }
            
            return cell
        }
    }
}
