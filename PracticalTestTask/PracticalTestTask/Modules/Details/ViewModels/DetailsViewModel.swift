//
//  DetailsViewModel.swift
//  PracticalTestTask
//
//  Created by Никита Пивоваров on 25.08.2023.
//

import Foundation
import Combine

class DetailsViewModel {
    
    let id: String
    
    @Published var state: States.LoadingStates = .idle
    public var detailsModel: DetailsModel = DetailsModel()
    private var storage: Set<AnyCancellable> = []
    
    init(id: String) {
        self.id = id
    }
    
    public func fetchData() {
        state = .loading
        
        guard let url = URL(string: Constants.stringURLs.getDetailsURL(id: id)) else {
            state = .failed(.wrongURL)
            return
        }
        
        NetworkService.request(DetailsDTO.self, url: url)
            .catch { error in
                self.state = .failed(error)
                return Just(DetailsDTO())
            }
            .map { DetailsModel(from: $0) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                if self?.state == States.LoadingStates.loading {
                    self?.detailsModel = model
                    self?.state = .loaded
                }
            }
            .store(in: &storage)
    }
}
