//
//  CheckboxViewModel.swift
//  DynamicForm
//
//  Created by Devanand Chauhan on 17/11/22.
//

import Foundation

class CheckboxViewModel: FormSectionType {
    
    let title: String
    let isRequired: Bool
    
    var type: FormType {
        return .checkbox
    }
    
    var item = [OptionViewModel]()
    
    var count: Int {
        return item.count
    }
    
    var selectedOptions: [OptionViewModel] {
        return item.filter { $0.isSelected == true }
    }
    
    var isValidated: Bool {
        return item.filter { $0.isSelected == true }.count > 0
    }
    
    required init(formField: FormField) {
        title = formField.displayTitle
        isRequired = formField.formFieldRequired
        formField.templateOptions.options?.forEach({ option in
            item.append(OptionViewModel(option: option, optionType: .checkbox))
        })
    }
}
