//
//  DetailsModel.swift
//  PracticalTestTask
//
//  Created by Никита Пивоваров on 25.08.2023.
//

import Foundation

struct DetailsDTO: Decodable {
    
    let id : String?
    let title : String?
    let price : String?
    let location : String?
    let imageURL : String?
    let createdDate : String?
    let description : String?
    let email : String?
    let phoneNumber : String?
    let address : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case title = "title"
        case price = "price"
        case location = "location"
        case imageURL = "image_url"
        case createdDate = "created_date"
        case description = "description"
        case email = "email"
        case phoneNumber = "phone_number"
        case address = "address"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL)
        createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        address = try values.decodeIfPresent(String.self, forKey: .address)
    }
    
    init() {
        id = nil
        title = nil
        price = nil
        location = nil
        imageURL = nil
        createdDate = nil
        description = nil
        email = nil
        phoneNumber = nil
        address = nil
    }
}
