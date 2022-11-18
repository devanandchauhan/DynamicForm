//
//  RatingTableViewCell.swift
//  DynamicForm
//
//  Created by Devanand Chauhan on 18/11/22.
//

import UIKit

class RatingTableViewCell: UITableViewCell {

    @IBOutlet weak var ratingView: StarRatingView!
    
    var viewModel: RatingViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        ratingView.value = { value in
            self.viewModel?.value = value
        }
    }
}
