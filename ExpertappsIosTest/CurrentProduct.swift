//
//  client.swift
//  CountryFood
//
//  Created by mohamed hashem on 7/15/20.
//  Copyright © 2020 mohamed hashem. All rights reserved.
//

import Foundation
import RxSwift

struct CurrentProductModel: Codable {

    var product: [Product] = []

    struct Product: Codable {
        var productId: Int?
        var productName: String = ""
        var initDate: TimeInterval?
    }

    static func encodeObject(currentObject: CurrentProductModel) {
        let objectData = try? PropertyListEncoder().encode(currentObject)
        objectData != nil ? (UserDefaults.standard.set(objectData!, forKey: "EncodeCurrentObject")) : ()
    }

    static func decodeObject() -> CurrentProductModel? {
        let storedObject = UserDefaults.standard.object(forKey: "EncodeCurrentObject") as? Data
        if storedObject != nil {
            let storedObject = try? PropertyListDecoder().decode(CurrentProductModel.self, from: storedObject!)
            return storedObject
        } else {
            return nil
        }
    }
}

final class CurrentProduct {
    static var product: BehaviorSubject<CurrentProductModel?> = BehaviorSubject(value: CurrentProductModel.decodeObject())
}
