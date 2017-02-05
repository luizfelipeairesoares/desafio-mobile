//
//  ProductsViewController.swift
//  desafio-mobile
//
//  Created by Luiz Aires Soares on 24/01/17.
//  Copyright © 2017 Stone. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var viewmodel: ProductsViewModel = ProductsViewModel()
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Produtos"
        
        self.viewmodel.assignController(controller: self)
        self.viewmodel.requestProducts()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.title = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button Actions
    
    @IBAction func btnCartTouched(_ sender: UIBarButtonItem) {
        let cart = self.storyboard?.instantiateViewController(withIdentifier: CartViewController.storyboardID()) as! CartViewController
        cart.assignViewModel(viewmodel: self.viewmodel)
        self.navigationController?.pushViewController(cart, animated: true)
    }
    
    @IBAction func btnBuyTouched(_ sender: UIButton) {
        let product = self.viewmodel.products[sender.tag]
        let contain = self.viewmodel.cart.contains { (p) -> Bool in
            return product.title == p.title
        }
        if contain == false {
            self.viewmodel.cart.append(product)
            self.showAlert(title: "", message: "Item adicionado ao carrinho!")
        } else {
            self.showAlert(title: "", message: "Item já adicionado ao carrinho!")
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

extension ProductsViewController: ProductProtocol {
    
    func reloadTable() {
        self.hideLoading()
        self.collectionView.reloadData()
    }
    
}

extension ProductsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewmodel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.cellIdentifier(), for: indexPath) as! ProductCollectionViewCell
        cell.configureCell(object: self.viewmodel.products[indexPath.row] as AnyObject)
        cell.btnBuy.tag = indexPath.row
        return cell
    }
    
}

extension ProductsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

extension ProductsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width-64), height: (collectionView.frame.size.height-32))
    }
    
}
