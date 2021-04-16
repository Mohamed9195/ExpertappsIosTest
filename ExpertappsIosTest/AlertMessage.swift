//
//  AlertMessage.swift
//  CountryFood
//
//  Created by mohamed hashem on 7/1/20.
//  Copyright © 2020 mohamed hashem. All rights reserved.
//

import UIKit
import SwiftMessages

class PopUpAlert {

    let alert: UIAlertController

    init(title: String? = nil, message: String? = nil, type: UIAlertController.Style = .alert) {
        alert = UIAlertController(title: title, message: message, preferredStyle: type)
    }

    func add(action: UIAlertAction) -> Self {
        alert.addAction(action)
        return self
    }

    func addCancelAction(title: String = "Cancel") -> Self {
        alert.addAction(UIAlertAction(title: title, style: .cancel, handler: nil))
        return self
    }

    func show(in vc: UIViewController? = nil) {
        if let vc = vc {
            vc.present(alert, animated: true, completion: nil)
        }
    }

    class func showSuccessToastWith(message: String) {
        let messageView = MessageView.viewFromNib(layout: .tabView)

        messageView.button?.isHidden = true
        messageView.titleLabel?.isHidden = true
        messageView.configureContent(body: message)
        messageView.configureTheme(.success)

        //FIXME: remove hideAll()
        SwiftMessages.hideAll()

        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .top
        config.ignoreDuplicates = false
        config.duration = .seconds(seconds: 3)
        DispatchQueue.main.async {
            SwiftMessages.show(config: config, view: messageView)
        }
    }

}
