//
//  FormProtocol.swift
//  CoinBalance
//
//  Created by Taylor Masterson on 2/13/18.
//  Copyright © 2018 Taylor Masterson. All rights reserved.
//

import Foundation
import UIKit

// Conform receiver to have data validation behavior
protocol FormValidable {
    var isValid: Bool {get set}
    var isMandatory: Bool {get set}
    func checkValidity()
}

// Conform the view receiver to be updated with a form item
protocol FormUpdatable {
    func update(with formItem: FormItem)
}

// Conform receiver to have a form item property
protocol FormConformity {
    var formItem: FormItem? {get set}
}

