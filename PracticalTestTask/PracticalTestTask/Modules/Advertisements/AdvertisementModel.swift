//
//  AdvertisementModel.swift
//  PracticalTestTask
//
//  Created by Никита Пивоваров on 25.08.2023.
//

import Foundation

struct AdvertisementModel: Decodable {
    
    let id : String?
    let title : String?
    let price : String?
    let location : String?
    let imageURL : String?
    let createdDate : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case price = "price"
        case location = "location"
        case imageURL = "image_url"
        case createdDate = "created_date"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL)
        createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
    }
}

struct AdvertisementsModel: Decodable {
    let advertisements: [AdvertisementModel]
}
