//
//  String+.swift
//  DynamicForm
//
//  Created by Devanand Chauhan on 18/11/22.
//

import Foundation

extension String {
    /// Responsible for checking email from string
    ///
    /// - Returns Bool
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
