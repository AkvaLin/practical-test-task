//
//  AdvertisementModel.swift
//  PracticalTestTask
//
//  Created by Никита Пивоваров on 25.08.2023.
//

import Foundation

struct AdvertisementModel: Decodable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageUrl: String
    let createDate: String
}
