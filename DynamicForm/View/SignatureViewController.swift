//
//  SignatureViewController.swift
//  DynamicForm
//
//  Created by Devanand Chauhan on 18/11/22.
//

import UIKit

class SignatureViewController: UIViewController {

    @IBOutlet weak var signatureView: SignatureView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        signatureView.layer.borderColor = UIColor.black.cgColor
        signatureView.layer.borderWidth = 1.0
        signatureView.layer.cornerRadius = 3
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveSignature(_:)))
        
    }
    
    @objc var saveSignature : ((UIImage) -> Void)?
    
    @IBAction func clearSignature(_ sender: UIButton) {
        self.signatureView.clear()
    }
    
    @IBAction func saveSignature(_ sender: UIButton) {
        
        if let image = signatureView.signature {
            saveSignature?(image)
            navigationController?.popViewController(animated: true)
        }
    }
}
