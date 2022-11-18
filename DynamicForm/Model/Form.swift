//
//  Form.swift
//  DynamicForm
//
//  Created by Devanand Chauhan on 17/11/22.
//

import Foundation

// MARK: - Form
struct Form: Codable {
    let formName: String
    let formFields: [FormField]

    enum CodingKeys: String, CodingKey {
        case formName = "form_name"
        case formFields = "form_fields"
    }
}

// MARK: - FormField
struct FormField: Codable {
    let key: FormType
    let type: String
    let formFieldRequired: Bool
    let templateOptions: TemplateOptions

    enum CodingKeys: String, CodingKey {
        case key, type
        case formFieldRequired = "required"
        case templateOptions
    }
}

extension FormField {
    var displayTitle: String {
        if formFieldRequired {
            return "*" + templateOptions.label
        } else {
            return templateOptions.label
        }
    }
}

// MARK: - TemplateOptions
struct TemplateOptions: Codable {
    let label: String
    let hideFieldUnderline: Bool
    let appearance: String
    let options: [Option]?
}

// MARK: - Option
struct Option: Codable, Equatable {
    let label: String
    let value: String
}

// MARK: - FormType
enum FormType: String, Codable {
    case email
    case radio
    case checkbox
    case signature
    case rating
    case text
    
    enum CodingKeys: String, CodingKey {
        case email
        case radio
        case checkbox
        case signature
        case rating
        case text
    }
}
