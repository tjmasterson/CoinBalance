//
//  FormItem.swift
//  CoinBalance
//
//  Created by Taylor Masterson on 2/13/18.
//  Copyright © 2018 Taylor Masterson. All rights reserved.
//

import UIKit

struct FormItemUIProperties {
    var tintColor = UIColor.red
    var keyboardType = UIKeyboardType.default
    var cellType: AnyObject?
    var timeStyle: DateFormatter.Style?
    var dateStyle: DateFormatter.Style?
}

class FormItem: FormValidable {
    
    var value: String?
    var placeholder = ""
    var label = ""
    var indexPath: IndexPath?
    var valueCompletion: ((String?) -> Void)?
    
    var isMandatory = true
    var isValid = true // FormValidable
    
    var uiProperties = FormItemUIProperties()
    
    // MARK: Init
    init(placeholder: String, value: String? = nil, label: String? = nil) {
        self.placeholder = placeholder
        self.value = value
        if let label = label {
            self.label = label
        }
    }
    
    // MARK: FormValidable
    func checkValidity() {
        if self.isMandatory {
            self.isValid = self.value != nil && self.value?.isEmpty == false
        } else {
            self.isValid = true
        }
    }
    
    func addToolbarInputAccessoryView(_ textField: UITextField?, notifyWith: String) {
        let toolbar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(self.saveButtonClicked(sender:)))
        
        toolbar.sizeToFit()
        toolbar.setItems([flexibleSpace, saveButton, flexibleSpace], animated: false)
        toolbar.isTranslucent = false
        toolbar.barTintColor = .green
        textField?.inputAccessoryView = toolbar
        textField?.reloadInputViews()
    }
    
    @objc func saveButtonClicked(sender: AnyObject) {
        print(sender)
        NotificationCenter.default.post(name: Notification.Name(rawValue: ""), object: nil)
    }
    

}
