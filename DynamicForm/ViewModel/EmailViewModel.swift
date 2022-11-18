//
//  EmailViewModel.swift
//  DynamicForm
//
//  Created by Devanand Chauhan on 17/11/22.
//

import Foundation

class EmailViewModel: FormSectionType {
    
    let title: String
    let isRequired: Bool
    
    var type: FormType {
        return .email
    }
    
    var value: String?
    
    var isValidated: Bool {
        if isRequired {
            return (value?.isEmail ?? false)
        } else {
            return true
        }
    }
    
    required init(formField: FormField) {
        isRequired = formField.formFieldRequired
        title = formField.displayTitle
    }
    
}
