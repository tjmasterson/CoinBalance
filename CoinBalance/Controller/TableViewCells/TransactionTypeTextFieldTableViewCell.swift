//
//  TransactionTextFieldTableViewCell.swift
//  CoinBalance
//
//  Created by Taylor Masterson on 2/14/18.
//  Copyright © 2018 Taylor Masterson. All rights reserved.
//

import UIKit

class TransactionTextFieldTableViewCell: UITableViewCell, FormConformity {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    var formItem: FormItem? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        label.text = formItem?.label
        formItem?.addToolbarInputAccessoryView(textField, notifyWith: "SaveTransaction")
        self.textField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
        self.formItem?.valueCompletion?(textField.text)
    }

    
}

// MARK: - FormUpdatable
extension TransactionTextFieldTableViewCell: FormUpdatable {
    func update(with formItem: FormItem) {
        self.formItem = formItem
        
        self.textField.text = self.formItem?.value
        
        let bgColor: UIColor = self.formItem?.isValid == false ? .red : .white
        self.textField.layer.backgroundColor = bgColor.cgColor
        self.textField.placeholder = self.formItem?.placeholder
        self.textField.keyboardType = self.formItem?.uiProperties.keyboardType ?? .default
        self.textField.tintColor = self.formItem?.uiProperties.tintColor
    }
}

extension TransactionTextFieldTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
