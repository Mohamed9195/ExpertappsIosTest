//
//  SkeltonTableViewCell.swift
//  CountryFood
//
//  Created by mohamed hashem on 7/15/20.
//  Copyright © 2020 mohamed hashem. All rights reserved.
//

import UIKit
import SkeletonView

class SkeltonTableViewCell: UITableViewCell {

    @IBOutlet weak var imageSkelton: UIImageView!
    @IBOutlet weak var stackSkelton: UIStackView!
    @IBOutlet weak var foodTypeView: UIView!
    @IBOutlet weak var kitchenNameView: UIView!
    @IBOutlet weak var deliveryView: UIView!
    @IBOutlet weak var deliveryType: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        imageSkelton.showAnimatedGradientSkeleton()
        foodTypeView.showAnimatedGradientSkeleton()
        kitchenNameView.showAnimatedGradientSkeleton()
        deliveryView.showAnimatedGradientSkeleton()
        deliveryType.showAnimatedGradientSkeleton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
