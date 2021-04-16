//
//  UIKit_Localize_Keys.swift
//  CountryFood
//
//  Created by mohamed hashem on 6/30/20.
//  Copyright © 2020 mohamed hashem. All rights reserved.
//

import UIKit

extension UILabel {
    @IBInspectable
    var localizedTextKey: String {
        set{
            self.text = NSLocalizedString(newValue, comment: "")
               // newValue.localized
        }

        get{
            return text ?? ""
        }
    }
}

extension UISegmentedControl {
    @IBInspectable
    var lSe0Key: String {
        set{
            self.setTitle(newValue, forSegmentAt: 0)
        }

        get{
            return titleForSegment(at: 0) ?? ""
        }
    }

    @IBInspectable
    var lSe1Key: String {
        set{
            self.setTitle(newValue, forSegmentAt: 1)
        }

        get{
            return titleForSegment(at: 1) ?? ""
        }
    }
}

extension UIImageView {

    @IBInspectable
    override var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

extension UIView {

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
