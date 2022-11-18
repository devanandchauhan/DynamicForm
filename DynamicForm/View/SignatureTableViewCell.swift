//
//  SignatureTableViewCell.swift
//  DynamicForm
//
//  Created by Devanand Chauhan on 18/11/22.
//

import UIKit

class SignatureTableViewCell: UITableViewCell {
    
    @IBOutlet weak var signatureView: UIImageView!
    
    var showSignature : (() -> Void)?
    
    var viewModel: SignatureViewModel? {
        didSet {
            if let viewModel = viewModel {
                updateView(model: viewModel)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        signatureView.layer.borderColor = UIColor.black.cgColor
        signatureView.layer.borderWidth = 1.0
        signatureView.layer.cornerRadius = 5
    }
    
    func updateView(model: SignatureViewModel) {
        signatureView.image = model.value
        let tap = UITapGestureRecognizer(target: self, action: #selector(showSign))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
    
    @objc func showSign() {
        showSignature?()
    }
    
}
