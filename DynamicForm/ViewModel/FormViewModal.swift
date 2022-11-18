//
//  FormViewModel.swift
//  DynamicForm
//
//  Created by Devanand Chauhan on 17/11/22.
//

import Foundation

protocol FormSectionType {
    var title: String { get }
    var type: FormType { get }
    var count: Int { get }
    var isRequired: Bool { get }
    var isValidated: Bool { get }
    
    init(formField: FormField)
}

extension FormSectionType {
    var count: Int {
        return 1
    }
}

class FormViewModel {
    
    let title: String
    
    var sections = [FormSectionType]()
    
    init(form: Form) {
        title = form.formName
        for item in form.formFields {
            switch item.key {
            case .email:
                sections.append(EmailViewModel(formField: item))
            case .radio:
                sections.append(RadioViewModel(formField: item))
            case .checkbox:
                sections.append(CheckboxViewModel(formField: item))
            case .signature:
                sections.append(SignatureViewModel(formField: item))
            case .rating:
                sections.append(RatingViewModel(formField: item))
            case .text:
                sections.append(TextViewModel(formField: item))
            }
        }
    }
    
    func isFormValid() -> Bool {
        return sections.filter { $0.isValidated == true }.count == sections.count
    }
}

