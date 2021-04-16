//
//  kitchenTableViewCell.swift
//  CountryFood
//
//  Created by mohamed hashem on 7/5/20.
//  Copyright © 2020 mohamed hashem. All rights reserved.
//

import UIKit

class kitchenTableViewCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!

    var addCartClosure: (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func touchUpToAddCart(_ sender: UIButton) {
        addCartClosure?()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
