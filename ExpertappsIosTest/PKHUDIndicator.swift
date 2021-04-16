//
//  PKHUDIndicator.swift
//  CountryFood
//
//  Created by mohamed hashem on 7/1/20.
//  Copyright © 2020 mohamed hashem. All rights reserved.
//

import Foundation
import PKHUD

class PKHUDIndicator {

    class func showProgressView() {
        HUD.hide(afterDelay: 30)
        HUD.show(.systemActivity)
    }

    class func hidProgressView() {
        HUD.hide()
    }
}
