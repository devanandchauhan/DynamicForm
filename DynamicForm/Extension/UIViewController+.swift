//
//  UIViewController+.swift
//  DynamicForm
//
//  Created by Devanand Chauhan on 17/11/22.
//

import UIKit

extension UIViewController {
    
    /// Responsible to setting up gesture on view to dismiss keyboard.
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    /// Responsible for dismissing keyboard.
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
