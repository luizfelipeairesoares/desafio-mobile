//
//  ControllersProtocol.swift
//  desafio-mobile
//
//  Created by Luiz Aires Soares on 30/01/17.
//  Copyright © 2017 Stone. All rights reserved.
//

import Foundation
import UIKit
import PKHUD

protocol ControllersProtocol {
    
    static func storyboardID() -> String
    func showLoading()
    func hideLoading()
    func showAlert(title: String, message: String)
    
}

extension ControllersProtocol where Self: UIViewController {
    
    static func storyboardID() -> String {
        return "\(self)StoryboardID"
    }
    
    func showLoading() {
        HUD.show(.progress)
    }
    
    func hideLoading() {
        HUD.flash(.success, delay: 0.2)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
