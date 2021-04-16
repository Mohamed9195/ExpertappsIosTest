//
//  HomeModelView.swift
//  ExpertappsIosTest
//
//  Created by mohamed hashem on 16/04/2021.
//

import Foundation
import RxSwift

protocol HomeViewModelOutput: class {
    func present(homeIsLoading: Bool)
    func present(error: Error)
    func present(product: CurrentProductModel)
    func present(productCached: Bool)
}

final class HomePostViewModel {

    weak var homeDelegate: HomeViewModelOutput?

    var homeIsLoading: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    var product: BehaviorSubject<CurrentProductModel?> = BehaviorSubject(value: nil)

    func getProductByDelegation() {
        homeDelegate?.present(homeIsLoading: true)

        sleep(8)

        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "ProductEvent", ofType: "json") else {
            fatalError("ProductEvent.json cannot be loaded")
        }

        guard let json = try? String(contentsOfFile: path) else { fatalError("Cannot load json file") }

        // Codable
        guard let jsonDecoderProductsEventInfo = try? JSONDecoder().decode(CurrentProductModel.self,
                                                                             from: json.data(using: .utf8)!) else {
                                                                             fatalError("ProductEvent is not found") }

        homeDelegate?.present(homeIsLoading: false)
        homeDelegate?.present(product: jsonDecoderProductsEventInfo)
    }

    func getProductByReactiveX() {
        homeIsLoading.onNext(true)

        sleep(2)

        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "ProductEvent", ofType: "json") else {
            fatalError("ProductEvent.json cannot be loaded")
        }

        guard let json = try? String(contentsOfFile: path) else { fatalError("Cannot load json file") }

        // Codable
        guard let jsonDecoderProductsEventInfo = try? JSONDecoder().decode(CurrentProductModel.self,
                                                                             from: json.data(using: .utf8)!) else {
                                                                             fatalError("ProductEvent is not found") }

        homeIsLoading.onNext(false)
        product.onNext(jsonDecoderProductsEventInfo)
    }

    func cacheProduct(product: CurrentProductModel.Product) {
        if var currentCart = CurrentProductModel.decodeObject() {
            currentCart.product.append(product)
            CurrentProductModel.encodeObject(currentObject: currentCart)
            homeDelegate?.present(productCached: true)
        } else {
            let newProductModel = CurrentProductModel(product: [product])
            CurrentProductModel.encodeObject(currentObject: newProductModel)
            homeDelegate?.present(productCached: true)
        }
    }
}
