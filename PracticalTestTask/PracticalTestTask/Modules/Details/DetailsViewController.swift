//
//  DetailsViewController.swift
//  PracticalTestTask
//
//  Created by Никита Пивоваров on 25.08.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private let viewModel: DetailsViewModel
    
    init(id: String) {
        self.viewModel = DetailsViewModel(id: id)
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
    }

}
