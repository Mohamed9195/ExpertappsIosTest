//
//  CartViewModel.swift
//  ExpertappsIosTest
//
//  Created by mohamed hashem on 16/04/2021.
//

import Foundation
import RxSwift

protocol CartViewModelOutput: class {
    func present(error: Error)
    func present(cart: CurrentProductModel)
}

final class CartViewModel {

    weak var cartDelegate: CartViewModelOutput?

    func getMyCart(withRemoveOldFrom: Int) {
        if let cart = CurrentProductModel.decodeObject() {
            cartDelegate?.present(cart: cart)
            checkMyCart(removeOldFrom: withRemoveOldFrom)
        }
    }

    // check if product date from 3 days app will remove it.
    private func checkMyCart(removeOldFrom: Int) {
        if let cart = CurrentProductModel.decodeObject() {
            var newCart = CurrentProductModel()

            cart.product.forEach { Product in
                if let creationDateStamp = Product.initDate {
                    let creationDate = Date(timeIntervalSince1970: creationDateStamp)
                    let interval = Calendar.current.dateComponents([.day],
                                                                   from: creationDate,
                                                                   to: Date())
                    if let daysAgo = interval.day, daysAgo < removeOldFrom {
                        newCart.product.append(Product)
                    }
                }
            }

            if newCart.product.count > 0 {
                UserDefaults.standard.removeObject(forKey: "EncodeCurrentObject")
                CurrentProductModel.encodeObject(currentObject: newCart)
            }

            if let cart = CurrentProductModel.decodeObject() {
                cartDelegate?.present(cart: cart)
            }
        }
    }
}
