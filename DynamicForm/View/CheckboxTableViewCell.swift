//
//  CheckboxTableViewCell.swift
//  DynamicForm
//
//  Created by Devanand Chauhan on 17/11/22.
//

import UIKit

class CheckboxTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var checkbox: UIButton!
    
    var viewModel: OptionViewModel? {
        didSet {
            if let viewModel = viewModel {
                updateView(model: viewModel)
            }
        }
    }
    
    var selectedOption: ((OptionViewModel, Int) -> Void)?
    
    var section: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    
    @IBAction func checkboxClicked(_ sender: Any) {
        checkbox.isSelected = !checkbox.isSelected
        viewModel?.isSelected = checkbox.isSelected
        if let viewModel = viewModel {
            selectedOption?(viewModel, section)
        }
    }
    
    func updateView(model: OptionViewModel) {
        title.text = model.option.label
        checkbox.isSelected = model.isSelected
        
        if model.optionType == .radio {
            checkbox.setImage(UIImage(systemName:"circle"), for: .normal)
            checkbox.setImage(UIImage(systemName:"smallcircle.filled.circle"), for: .selected)
        } else {
            checkbox.setImage(UIImage(systemName:"square"), for: .normal)
            checkbox.setImage(UIImage(systemName:"checkmark.square"), for: .selected)
        }
    }
}
