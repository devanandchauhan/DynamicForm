//
//  RadioViewModel.swift
//  DynamicForm
//
//  Created by Devanand Chauhan on 17/11/22.
//

import Foundation

class RadioViewModel: FormSectionType {
    
    let title: String
    let isRequired: Bool
    
    var type: FormType {
        return .radio
    }
    
    var item = [OptionViewModel]()
    
    var count: Int {
        return item.count
    }
    
    var selectedOption: OptionViewModel? {
        return item.filter { $0.isSelected == true }.first
    }
    
    var isValidated: Bool {
        if isRequired {
            return item.filter { $0.isSelected == true }.count > 0
        } else {
            return true
        }
    }
    
    required init(formField: FormField) {
        title = formField.displayTitle
        isRequired = formField.formFieldRequired
        formField.templateOptions.options?.forEach({ option in
            item.append(OptionViewModel(option: option, optionType: .radio))
        })
    }
    
    func updateSelection(option: OptionViewModel) {
        for i in item.indices {
            item[i].isSelected = item[i] == option
        }
    }
}
