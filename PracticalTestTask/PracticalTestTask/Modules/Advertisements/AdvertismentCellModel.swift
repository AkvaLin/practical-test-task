//
//  AdvertismentCellModel.swift
//  PracticalTestTask
//
//  Created by Никита Пивоваров on 26.08.2023.
//

import Foundation

struct AdvertisementCellModel {
    let imageURL: URL?
    let title: String
    let price: String
    let location: String
    let date: String
    
    init(from advertisementModel: AdvertisementModel) {
        imageURL = URL(string: advertisementModel.imageURL ?? "")
        title = advertisementModel.title ?? ""
        price = advertisementModel.price ?? ""
        location = advertisementModel.location ?? ""
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let newDate = formatter.date(from: advertisementModel.createdDate ?? "") {
            formatter.dateStyle = .medium
            formatter.locale = .current
            date = formatter.string(from: newDate)
        } else {
            date = ""
        }
    }
}
