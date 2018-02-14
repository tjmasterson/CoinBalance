//
//  Form.swift
//  CoinBalance
//
//  Created by Taylor Masterson on 2/13/18.
//  Copyright © 2018 Taylor Masterson. All rights reserved.
//

import Foundation

class Form {
    var formItems = [FormItem]()
    
    var title: String? = ""
    
    // MARK: Form Validation
    @discardableResult
    func isValid() -> (Bool, String?) {
        
        var isValid = true
        for item in self.formItems {
            item.checkValidity()
            if !item.isValid {
                isValid = false
            }
        }
        return (isValid, nil)
    }
}
