//
//  OptionViewModel.swift
//  DynamicForm
//
//  Created by Devanand Chauhan on 17/11/22.
//

import Foundation

enum OptionType {
    case radio
    case checkbox
}

class OptionViewModel {
    
    var option: Option
    
    var optionType: OptionType
    
    var isSelected: Bool = false
    
    init(option: Option, optionType: OptionType) {
        self.option = option
        self.optionType = optionType
    }
}

extension OptionViewModel: Equatable {
    static func == (lhs: OptionViewModel, rhs: OptionViewModel) -> Bool {
        return lhs.option == rhs.option
    }
}
