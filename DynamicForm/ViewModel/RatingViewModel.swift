//
//  RatingViewModel.swift
//  DynamicForm
//
//  Created by Devanand Chauhan on 18/11/22.
//

import Foundation

class RatingViewModel: FormSectionType {
    
    let title: String
    let isRequired: Bool
    
    var type: FormType {
        return .rating
    }
    
    var value: Float?
    
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
