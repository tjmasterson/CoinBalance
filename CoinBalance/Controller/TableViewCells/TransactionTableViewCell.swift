//
//  TransactionTableViewCell.swift
//  CoinBalance
//
//  Created by Taylor Masterson on 2/12/18.
//  Copyright © 2018 Taylor Masterson. All rights reserved.
//

import UIKit

enum TransactionCell: Int {
    case coinPriceInUSD, dateOfTransaction, numberOfCoins, timeOfTransaction
    
    static var count = {
        return TransactionCell.titles.count
    }
    
    static let titles = [
        coinPriceInUSD: "Price in USD",
        dateOfTransaction: "Date",
        numberOfCoins: "Coin Amount",
        timeOfTransaction: "Time"
    ]
    
    func valueRequired() -> Bool {
        switch self {
        case .coinPriceInUSD, .dateOfTransaction, .numberOfCoins:
            return true
        default:
            return false
        }
    }
    
    func title() -> String {
        if let title = TransactionCell.titles[self] {
            return title
        } else {
            return ""
        }
    }

}

class TransactionTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    var indexPath: Int?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var cellType: TransactionCell? {
        didSet {
            updateUI()
        }
    }
    
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        valueTextField?.text = dateFormatter.string(from: sender.date)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "TextFieldDidUpdate"), object: self, userInfo: ["indexPath": self.indexPath!])
        
    }
    
    func addToolbarInputAccessoryView() -> UIToolbar {
        let toolbar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(self.saveButtonClicked))
        
        toolbar.sizeToFit()
        toolbar.setItems([flexibleSpace, saveButton, flexibleSpace], animated: false)
        toolbar.isTranslucent = false
        toolbar.barTintColor = .green
        return toolbar
    }
    
    @objc func saveButtonClicked() {
        valueTextField?.resignFirstResponder()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "SaveTransaction"), object: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

class TransactionTableViewCellNumber: TransactionTableViewCell {

    var indexPath: Int?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var cellType: TransactionCell? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        titleLabel?.text = cellType!.title()
        valueTextField?.delegate = self
        valueTextField?.keyboardType = UIKeyboardType.numberPad
    }
    
    func addToolbarInputAccessoryView() -> Void {
        let toolbar = super.addToolbarInputAccessoryView()
        valueTextField?.inputAccessoryView = toolbar
        valueTextField?.reloadInputViews()
    }
    
}

class TransactionTableViewCellTime: TransactionTableViewCell {
    
    var indexPath: Int?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!

    
    var cellType: TransactionCell? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        titleLabel?.text = cellType!.title()
        valueTextField?.delegate = self
        
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.time
        valueTextField?.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: UIControlEvents.valueChanged)

    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        valueTextField?.text = dateFormatter.string(from: sender.date)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "TextFieldDidUpdate"), object: self, userInfo: ["indexPath": self.indexPath!])
        
    }
}

class TransactionTableViewCellDate: TransactionTableViewCell {
    
    var indexPath: Int?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    
    var cellType: TransactionCell? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        titleLabel?.text = cellType!.title()
        valueTextField?.delegate = self
        
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        valueTextField?.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: UIControlEvents.valueChanged)
        }
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        valueTextField?.text = dateFormatter.string(from: sender.date)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "TextFieldDidUpdate"), object: self, userInfo: ["indexPath": self.indexPath!])
        
    }
    
}



