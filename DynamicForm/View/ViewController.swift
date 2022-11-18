//
//  ViewController.swift
//  DynamicForm
//
//  Created by Devanand Chauhan on 17/11/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = FormViewModel(form: Bundle.main.decode(Form.self, from: "form2.json"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = viewModel.title
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TextTableViewCell", bundle: nil), forCellReuseIdentifier: "TextTableViewCell")
        tableView.register(UINib(nibName: "EmailTableViewCell", bundle: nil), forCellReuseIdentifier: "EmailTableViewCell")
        tableView.register(UINib(nibName: "CheckboxTableViewCell", bundle: nil), forCellReuseIdentifier: "CheckboxTableViewCell")
        tableView.register(UINib(nibName: "SignatureTableViewCell", bundle: nil), forCellReuseIdentifier: "SignatureTableViewCell")
        tableView.register(UINib(nibName: "RatingTableViewCell", bundle: nil), forCellReuseIdentifier: "RatingTableViewCell")
        tableView.register(UINib(nibName: "FormHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "FormHeaderView")
        tableView.separatorStyle = .none
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(submitClicked))
        
        hideKeyboard()
    }
    
    func showSignature() {
        if let signatureVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignatureViewController") as? SignatureViewController {
            navigationController?.pushViewController(signatureVC, animated: true)
            signatureVC.saveSignature = { image in
                if let signVM =  self.viewModel.sections.filter({ $0.type == .signature}).first as? SignatureViewModel  {
                    signVM.value = image
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @objc func submitClicked() {
        print("FormCompleted: \(viewModel.isFormValid())")
        viewModel.sections.forEach { object in
            print("Section: \(object.title) req: \(object.isRequired) val: \(object.isValidated)")
        }
        showAlert(with: viewModel.isFormValid())
    }
    
    func showAlert(with result: Bool) {
        dismissKeyboard()
        let alert = UIAlertController(title: result ? "Success" : "Error", message: result ? "You have successfully completed the form." : "You have not filled the mandatory fields. Request to fill the same." , preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: false, completion: nil)
        }
    }
}

// MARK: -  UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = viewModel.sections[indexPath.section]
        switch item.type {
        case .email:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmailTableViewCell", for: indexPath) as! EmailTableViewCell
            cell.viewModel = item as? EmailViewModel
            return cell
        case .radio:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckboxTableViewCell", for: indexPath) as! CheckboxTableViewCell
            let model = item as? RadioViewModel
            cell.viewModel = model?.item[indexPath.row]
            cell.section = indexPath.section
            cell.selectedOption = { (option, section) in
                print("Selected: \(option.option)")
                if let item = self.viewModel.sections[section] as? RadioViewModel {
                    item.updateSelection(option: option)
                    tableView.reloadSections(IndexSet(integer: section), with: .none)
                }
            }
            return cell
        case .checkbox:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckboxTableViewCell", for: indexPath) as! CheckboxTableViewCell
            let model = item as? CheckboxViewModel
            cell.viewModel = model?.item[indexPath.row]
            return cell
        case .signature:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SignatureTableViewCell", for: indexPath) as! SignatureTableViewCell
            cell.viewModel = item as? SignatureViewModel
            cell.showSignature = showSignature
            return cell
        case .rating:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RatingTableViewCell", for: indexPath) as! RatingTableViewCell
            cell.viewModel = item as? RatingViewModel
            return cell
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextTableViewCell", for: indexPath) as! TextTableViewCell
            cell.viewModel = item as? TextViewModel
            return cell
        }
    }
    
}

// MARK: -  UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FormHeaderView") as! FormHeaderView
        header.title.text = viewModel.sections[section].title
        return header
    }
}


