//
//  CardViewController.swift
//  desafio-mobile
//
//  Created by Luiz Aires Soares on 05/02/17.
//  Copyright © 2017 Stone. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var txtValid: UITextField!
    @IBOutlet weak var txtCVV: UITextField!
    
    fileprivate var tap: UITapGestureRecognizer?
    
    private weak var viewmodel: ProductsViewModel?
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func assignViewModel(viewmodel: ProductsViewModel?) {
        self.viewmodel = viewmodel
    }
    
    // MARK: - Button Actions
    
    @IBAction func btnCloseTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnBuyTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            self.viewmodel?.buyProducts(name: self.txtName.text!, number: self.txtNumber.text!, cvv: self.txtCVV.text!, valid: self.txtValid.text!)
        })
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        self.changeView(up: 0.0)
        self.view.removeGestureRecognizer(self.tap!)
    }
    
    // MARK: - Auxiliar Functions
    
    fileprivate func changeView(up: CGFloat) {
        UIView.animate(withDuration: 1.0) { 
            self.view.frame = CGRect(x: CGFloat(0.0), y: up, width: self.view.frame.width, height: self.view.frame.height)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CardViewController: ProductProtocol {
    
    func reloadTable() { }
    
}

extension CardViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.view.addGestureRecognizer(self.tap!)
        switch textField.tag {
        case 0:
            self.changeView(up: CGFloat(-20.0))
            break
        case 1:
            self.changeView(up: CGFloat(-40.0))
            break
        case 2:
            self.changeView(up: CGFloat(-60.0))
            break
        case 3:
            self.changeView(up: CGFloat(-150.0))
            break
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.changeView(up: 0.0)
        self.view.removeGestureRecognizer(self.tap!)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField.tag {
        case 0:
            let count = textField.text?.characters.count
            if string != "" && (count == 4 || count == 9 || count == 14) {
                textField.text?.append(" ")
                return true
            } else if count == 19 && string != "" {
                return false
            }
        case 2:
            let count = textField.text?.characters.count
            if count == 5 && string != "" {
                return false
            } else if count == 2 && string != "" {
                textField.text?.append("/")
                return true
            }
            break
        case 3:
            if textField.text?.characters.count == 3  && string != "" {
                return false
            } else {
                return true
            }
        default:
            return true
        }
        return true
    }
    
}
