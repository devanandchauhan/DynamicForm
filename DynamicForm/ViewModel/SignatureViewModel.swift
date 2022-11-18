//
//  SignatureViewModel.swift
//  DynamicForm
//
//  Created by Devanand Chauhan on 18/11/22.
//

import Foundation
import UIKit

class SignatureViewModel: FormSectionType {
    
    let title: String
    let isRequired: Bool
    
    var type: FormType {
        return .signature
    }
    
    var value: UIImage?
    
    var isValidated: Bool {
        if isRequired {
            return value != nil
        } else {
            return true
        }
    }
    
    required init(formField: FormField) {
        title = formField.displayTitle
        isRequired = formField.formFieldRequired
    }
}
