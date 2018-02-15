//
//  TransactionTableViewController.swift
//  CoinBalance
//
//  Created by Taylor Masterson on 2/11/18.
//  Copyright © 2018 Taylor Masterson. All rights reserved.
//

import UIKit
import CoreData





class TransactionTableViewController: UITableViewController {
    
    var context: NSManagedObjectContext? = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext

    var transaction: Transaction?
    
    fileprivate var form = TransactionForm()
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.form = TransactionForm()
        self.tableView.reloadData()
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "SaveTransaction"),
                                               object: nil,
                                               queue: nil,
                                               using: saveTransaction(_:))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name(rawValue: "SaveTransaction"),
                                                  object: nil)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.form.formItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.form.formItems[indexPath.row]
        let cell: UITableViewCell
        if let cellType = self.form.formItems[indexPath.row].uiProperties.cellType {
            cell = cellType.dequeueCell(for: tableView, at: indexPath)
        } else {
            cell = UITableViewCell() //or anything you want
        }
        
        if let formUpdatableCell = cell as? FormUpdatable {
            item.indexPath = indexPath
            formUpdatableCell.update(with: item)
        }
        
        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cellType = self.form.formItems[indexPath.row].uiProperties.cellType {
            switch cellType {
            case .textFieldWithLabel:
                let cell = tableView.cellForRow(at: indexPath) as! TransactionTextFieldTableViewCell
                cell.textField?.becomeFirstResponder()
            case .dateTypeTextFieldWithLabel:
                let cell = tableView.cellForRow(at: indexPath) as! TransactionDateTypeTextFieldTableViewCell
                cell.textField?.becomeFirstResponder()
            }
        }
    }
    
//    private func saveTransaction(_ notification: Notification) -> Void {
//        if let context = context {
//            //            let dateFormatter = DateFormatter()
//            //            dateFormatter.dateFormat = "MM dd, yyyy"
//            if let transaction = transaction {
//                
//            } else {
//                let transaction = Transaction(context: context)
//            }
//            
//            let transaction = Transaction(context: context)
//            
//            do {
//                try context.save()
//            } catch {
//                print(error)
//            }
//            
//            dismiss(animated: true, completion: nil)
//        }
//    }

    private func saveTransaction(_ notification: Notification) -> Void {
//        if let context = context {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "MM dd, yyyy"
//            let transaction = Transaction(context: context)
//            for row in 0..<numberOfTableViewRows {
//                let indexPath = IndexPath(row: row, section: 0)
//                let cell = tableView.cellForRow(at: indexPath) as! AddTransactionTableViewCell
//                let type = cell.cellType!
//                switch (type) {
//                case .boughtAtPrice:
//                    transaction.boughtAtPrice = Double((cell.valueTextField?.text)!)!
//                case .currencyAmount:
//                    transaction.currencyAmount = Double((cell.valueTextField?.text)!)!
//                case .date:
//                    transaction.date = dateFormatter.date(from:(cell.valueTextField?.text)!)!
//                case .dollarsSpent:
//                    transaction.dollarsSpent = Double((cell.valueTextField?.text)!)!
//                }
//            }
//
//            account?.addToTransactions(transaction)
//            do {
//                try context.save()
//            } catch {
//                print(error)
//            }
//            dismiss(animated: true, completion: nil)
//        }
    }

}
