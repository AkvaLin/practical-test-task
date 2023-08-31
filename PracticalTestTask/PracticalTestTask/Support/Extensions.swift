//
//  Extensions.swift
//  PracticalTestTask
//
//  Created by Никита Пивоваров on 30.08.2023.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
