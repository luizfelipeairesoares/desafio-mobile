//
//  CartViewController.swift
//  desafio-mobile
//
//  Created by Luiz Aires Soares on 05/02/17.
//  Copyright © 2017 Stone. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var vwEmpty: UIView!
    
    fileprivate weak var viewmodel: ProductsViewModel?
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let barbutton = UIBarButtonItem(title: "Remover todos", style: .plain, target: self, action: #selector(self.btnRemoveAllTouched(_:)))
        self.navigationItem.rightBarButtonItem = barbutton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Carrinho"
        
        if self.viewmodel?.cart.count == 0 {
            self.vwEmpty.isHidden = false
        } else {
            self.vwEmpty.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func assignViewModel(viewmodel: ProductsViewModel) {
        self.viewmodel = viewmodel
        self.viewmodel?.assignController(controller: self)
    }
    
    // MARK: - Button Actions
    
    @IBAction func btnRemoveTouched(_ sender: UIButton) {
        self.viewmodel?.cart.remove(at: sender.tag)
        self.tblView.reloadData()
    }
    
    @IBAction func btnRemoveAllTouched(_ sender: UIBarButtonItem) {
        self.viewmodel?.cart.removeAll()
        self.tblView.reloadData()
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

extension CartViewController: ProductProtocol {
    
    func reloadTable() { }
    
}

// MARK: - UITableViewDataSource

extension CartViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewmodel?.cart.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.cellIdentifier(), for: indexPath) as! CartTableViewCell
        cell.configureCell(object: self.viewmodel!.cart[indexPath.row] as AnyObject?)
        cell.btnRemove.tag = indexPath.row
        return cell
    }
}

extension CartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.viewmodel?.cart.count == 0 {
            self.vwEmpty.isHidden = false
            return 0.0
        } else {
            return 100.0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if self.viewmodel?.cart.count == 0 {
            return nil
        } else {
            let vw = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 100))
            let btn = UIButton(frame: CGRect(x: ((vw.frame.size.width/2)-100), y: 28, width: 200, height: 44))
            btn.setTitle("FINALIZAR COMPRA", for: .normal)
            btn.backgroundColor = UIColor(colorLiteralRed: 33/255, green: 192/255, blue: 100/255, alpha: 1.0)
            vw.addSubview(btn)
            return vw
        }
    }
    
}
