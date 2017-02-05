//
//  CartTableViewCell.swift
//  desafio-mobile
//
//  Created by Luiz Aires Soares on 05/02/17.
//  Copyright © 2017 Stone. All rights reserved.
//

import UIKit
import Kingfisher

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnRemove: UIButton!
    
    // MARK: - Cell Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CartTableViewCell: CellProtocol {
    
    func configureCell(object: AnyObject?) {
        if let product = object as? ProductEntity {
            if let thumbnail = product.thumbnail {
                self.imgView.kf.setImage(with: thumbnail)
            }
            self.lblName.text = product.title
            if let price = product.price {
                self.lblPrice.text = String(format: "R$ %.02f", price)
            }
        }
    }
    
}
