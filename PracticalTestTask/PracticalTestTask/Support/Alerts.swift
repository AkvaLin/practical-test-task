//
//  Alerts.swift
//  PracticalTestTask
//
//  Created by Никита Пивоваров on 29.08.2023.
//

import Foundation
import UIKit

enum Alerts {
    static func getAlert(for error: NetworkService.FailureReason) -> UIAlertController {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        switch error {
        case .wrongURL:
            alert.title = "Ошибка"
            alert.message = "Не удалось получить доступ к серверу"
        case .sessionFailed:
            alert.title = "Ошибка"
            alert.message = "Не удалось получить ответ от сервера"
        case .decodingFailed:
            alert.title = "Ошибка"
            alert.message = "Не удалось расшифровать ответ сервера"
        case .other(let error):
            alert.title = "Ошибка"
            alert.message = "\(error.localizedDescription)"
        }
        return alert
    }
}
