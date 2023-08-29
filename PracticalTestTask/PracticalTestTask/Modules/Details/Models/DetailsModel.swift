//
//  DetailsModel.swift
//  PracticalTestTask
//
//  Created by Никита Пивоваров on 28.08.2023.
//

import Foundation

struct DetailsModel {
    
    let title : String
    let price : String
    let location : String
    let imageURL : URL?
    let createdDate : String
    let description : String
    let email : String
    let phoneNumber : String
    
    init(from detailsDTO: DetailsDTO) {
        title = detailsDTO.title ?? ""
        price = detailsDTO.price ?? ""
        imageURL = URL(string: detailsDTO.imageURL ?? "")
        createdDate = FormatDate.getFormatedDateString(dateString: detailsDTO.createdDate)
        description = detailsDTO.description ?? ""
        email = detailsDTO.email ?? ""
        phoneNumber = detailsDTO.phoneNumber ?? ""
        
        if let location = detailsDTO.location {
            if let address = detailsDTO.address {
                self.location = location + ", " + address
            } else {
                self.location = location
            }
        } else if let address = detailsDTO.address {
            self.location = address
        } else {
            self.location = ""
        }
    }
    
    init() {
        title = ""
        price = ""
        location = ""
        imageURL = nil
        createdDate = ""
        description = ""
        email = ""
        phoneNumber = ""
    }
}
