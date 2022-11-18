//
//  TextViewModel.swift
//  DynamicForm
//
//  Created by Devanand Chauhan on 17/11/22.
//

import Foundation

class TextViewModel: FormSectionType {
    
    let title: String
    let isRequired: Bool
    
    var type: FormType {
        return .text
    }
    
    var value: String?
    
    var isValidated: Bool {
        if isRequired {
            return !(value?.isEmpty ?? true)
        } else {
            return true
        }
    }
    
    required init(formField: FormField) {
        title = formField.displayTitle
        isRequired = formField.formFieldRequired
    }
}
