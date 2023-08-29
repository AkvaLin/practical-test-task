//
//  AdvertismentCellModel.swift
//  PracticalTestTask
//
//  Created by Никита Пивоваров on 26.08.2023.
//

import Foundation

struct AdvertisementCellModel {
    
    let id: String
    let imageURL: URL?
    let title: String
    let price: String
    let location: String
    let date: String
    
    init(from advertisementModel: AdvertisementModel) {
        id = advertisementModel.id ?? ""
        imageURL = URL(string: advertisementModel.imageURL ?? "")
        title = advertisementModel.title ?? ""
        price = advertisementModel.price ?? ""
        location = advertisementModel.location ?? ""
        date = FormatDate.getFormatedDateString(dateString: advertisementModel.createdDate)
    }
}
