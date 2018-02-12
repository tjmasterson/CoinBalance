//
//  TransactionTableViewController.swift
//  CoinBalance
//
//  Created by Taylor Masterson on 2/11/18.
//  Copyright © 2018 Taylor Masterson. All rights reserved.
//

import UIKit

class TransactionTableViewController: UITableViewController {

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "TextFieldDidUpdate"), object: nil, queue: nil, using: shouldPresentSaveButton(_:))
//        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "SaveTransaction"), object: nil, queue: nil, using: saveTransaction(_:))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "TextFieldDidUpdate"), object: nil)
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TransactionCell.count()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let transactionCell = TransactionCell(rawValue: indexPath.item) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath) as! TransactionTableViewCell
        
        cell.cellType = transactionCell
        cell.indexPath = indexPath.item

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // let addTransactionCell = AddTransactionCell(rawValue: indexPath.item)!
        let cell = tableView.cellForRow(at: indexPath)  as! TransactionTableViewCell
        cell.valueTextField?.becomeFirstResponder()
    }

    private func shouldPresentSaveButton(_ notification: Notification) -> Void  {
        let numberOfTableViewRows = tableView.numberOfRows(inSection: 0)
        if numberOfTableViewRows > 0 {
            for row in 0..<numberOfTableViewRows {
                let indexPath = IndexPath(row: row, section: 0)
                let cell = tableView.cellForRow(at: indexPath) as! TransactionTableViewCell
                if cell.valueTextField?.hasText == false {
                    return
                }
            }
        }
    
        presentSaveButton(notification.userInfo as! [String: Int])
    }
    
    private func presentSaveButton(_ userInfo: [String: Int]) {
        if let indexOfFirstResponder = userInfo["indexPath"] {
            let indexPath = IndexPath(row: indexOfFirstResponder, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! TransactionTableViewCell
            cell.addToolbarInputAccessoryView()
        }
    }
    
//    private func saveTransaction(_ notification: Notification) -> Void {
//        if let context = container?.viewContext {
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
//    }

}
