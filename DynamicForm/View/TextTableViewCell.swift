//
//  TextTableViewCell.swift
//  DynamicForm
//
//  Created by Devanand Chauhan on 17/11/22.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    var viewModel: TextViewModel?
    
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        viewModel?.value = sender.text
    }
    
}
