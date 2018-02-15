//
//  TransactionDateTypeTextFieldTableViewCell.swift
//  CoinBalance
//
//  Created by Taylor Masterson on 2/14/18.
//  Copyright © 2018 Taylor Masterson. All rights reserved.
//

import UIKit

class TransactionDateTypeTextFieldTableViewCell: UITableViewCell, FormConformity {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    var formItem: FormItem? {
        didSet {
            updateUI()
        }
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
        self.formItem?.valueCompletion?(textField.text)
    }
    
    func updateUI() {
        textField?.delegate = self
        label?.text = formItem!.label
        
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = (formItem?.uiProperties.datePickerMode)!
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: UIControlEvents.valueChanged)
        textField?.inputView = datePickerView
        
        formItem?.addToolbarInputAccessoryView(textField, saveNotifier: "SaveTransaction")
        textField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = (formItem?.uiProperties.dateStyle)!
        dateFormatter.timeStyle = (formItem?.uiProperties.timeStyle)!
        textField?.text = dateFormatter.string(from: sender.date)
    }
    
}

// MARK: - FormUpdatable
extension TransactionDateTypeTextFieldTableViewCell: FormUpdatable {
    func update(with formItem: FormItem) {
        self.formItem = formItem
        
        self.textField.text = self.formItem?.value
        
        let bgColor: UIColor = self.formItem?.isValid  == false ? .red : .white
        self.textField.layer.backgroundColor = bgColor.cgColor
        self.textField.placeholder = self.formItem?.placeholder
        self.textField.keyboardType = self.formItem?.uiProperties.keyboardType ?? .default
        self.textField.tintColor = self.formItem?.uiProperties.tintColor
    }
}

extension TransactionDateTypeTextFieldTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

