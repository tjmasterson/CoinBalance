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
    
    var coinPriceInUSD: String?
    var dateOfTransaction: String?
    var numberOfCoins: String?
    var timeOfTransaction: String?

    
    override init() {
        super.init()
        self.configureItems()
    }
    
    /// Prepare all form Items ViewModels for the DirectStudioForm
    private func configureItems() {
        
        // Number of Coins
        let numberOfCoins = FormItem(placeholder: "Tap to Edit", label: "Total Coins")
        numberOfCoins.uiProperties.cellType = TransactionFormItemCellType.textFieldWithLabel
        numberOfCoins.value = self.numberOfCoins
        numberOfCoins.uiProperties.keyboardType = .numberPad
        numberOfCoins.valueCompletion = { [weak self, weak numberOfCoins] value in
            self?.numberOfCoins = value
            numberOfCoins?.value = value
        }
        
        // Coin Price in USD
        let coinPriceInUSD = FormItem(placeholder: "Tap to Edit", label: "Price in USD")
        coinPriceInUSD.uiProperties.cellType = TransactionFormItemCellType.textFieldWithLabel
        coinPriceInUSD.value = self.coinPriceInUSD
        coinPriceInUSD.uiProperties.keyboardType = .numberPad
        coinPriceInUSD.valueCompletion = { [weak self, weak coinPriceInUSD] value in
            self?.coinPriceInUSD = value
            coinPriceInUSD?.value = value
        }
        
        
        // Date Of Transaction
        let dateOfTransaction = FormItem(placeholder: "Tap to Edit", label: "Date")
        dateOfTransaction.uiProperties.cellType = TransactionFormItemCellType.dateTypeTextFieldWithLabel
        dateOfTransaction.uiProperties.dateStyle = DateFormatter.Style.short
        dateOfTransaction.uiProperties.timeStyle = DateFormatter.Style.none
        dateOfTransaction.uiProperties.datePickerMode = UIDatePickerMode.date
        dateOfTransaction.value = self.dateOfTransaction
        dateOfTransaction.valueCompletion = { [weak self, weak dateOfTransaction] value in
            self?.dateOfTransaction = value
            dateOfTransaction?.value = value
        }
        
        // Time Of Transaction
        let timeOfTransaction = FormItem(placeholder: "Tap to Edit", label: "Time")
        timeOfTransaction.uiProperties.cellType = TransactionFormItemCellType.dateTypeTextFieldWithLabel
        timeOfTransaction.uiProperties.dateStyle = DateFormatter.Style.none
        timeOfTransaction.uiProperties.timeStyle = DateFormatter.Style.short
        timeOfTransaction.uiProperties.datePickerMode = UIDatePickerMode.time
        timeOfTransaction.value = self.dateOfTransaction
        timeOfTransaction.isMandatory = false
        timeOfTransaction.valueCompletion = { [weak self, weak timeOfTransaction] value in
            self?.timeOfTransaction = value
            timeOfTransaction?.value = value
        }
        
        self.formItems = [numberOfCoins, coinPriceInUSD, dateOfTransaction, timeOfTransaction]
    }
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
    
//    func getCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
//        let cell: UITableViewCell
//
//        switch self {
//        case .textFieldWithLabel:
//            cell = tableView.cellForRow(at: indexPath) as! TransactionTextFieldTableViewCell
//        case .dateTypeTextFieldWithLabel:
//            cell = tableView.cellForRow(at: indexPath) as! TransactionDateTypeTextFieldTableViewCell
//        }
//        return cell
//    }
}
