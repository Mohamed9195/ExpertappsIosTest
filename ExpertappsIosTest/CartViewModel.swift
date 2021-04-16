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

    func getMyCart() {
        if let cart = CurrentProductModel.decodeObject() {
            cartDelegate?.present(cart: cart)
            checkMyCart()
        }
    }


    private func checkMyCart() {
        if let cart = CurrentProductModel.decodeObject() {
            var newCart = CurrentProductModel()

            cart.product.forEach { Product in
                if let creationDateStamp = Product.initDate {
                    let creationDate = Date(timeIntervalSince1970: creationDateStamp)
                    let interval = Calendar.current.dateComponents([.day],
                                                                   from: creationDate,
                                                                   to: Date())
                    if let daysAgo = interval.day, daysAgo < 2 {
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
