//
//  ProductTableViewCell.swift
//  desafio-mobile
//
//  Created by Luiz Aires Soares on 24/01/17.
//  Copyright © 2017 Stone. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell, CellProtocol {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblSeller: UILabel!
    @IBOutlet weak var btnBuy: UIButton!
    
    // MARK: - Cell Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func draw(_ rect: CGRect) {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        
    }
    
    // MARK: - Custom Cell Methods
    
    func configureCell(object: AnyObject?) {
        if object != nil && object is ProductEntity {
            let product = object as! ProductEntity
            if let thumb = product.thumbnail {
                self.img.kf.setImage(with: thumb,
                                     placeholder: UIImage(named: "img_placeholder"),
                                     options: nil,
                                     progressBlock: nil,
                                     completionHandler: { [unowned self] (image, error, cache, url) in
                    if image != nil {
                        self.img.image = image
                    }
                })
            }
            self.lblTitle.text = product.title
            if let price = product.price {
                self.lblPrice.text = String(format: "R$ %.02f", price)
            }
            if let seller = product.seller {
                self.lblSeller.text = "Vendedor: \(seller)"
            }
        }
    }

}
