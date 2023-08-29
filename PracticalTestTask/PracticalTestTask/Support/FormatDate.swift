//
//  FormatDate.swift
//  PracticalTestTask
//
//  Created by Никита Пивоваров on 28.08.2023.
//

import Foundation

enum FormatDate {
    static func getFormatedDateString(dateString: String?) -> String {
        
        guard let dateString = dateString else { return "" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let newDate = formatter.date(from: dateString) {
            formatter.dateStyle = .medium
            formatter.locale = .current
            return formatter.string(from: newDate)
        } else {
            return ""
        }
    }
}
