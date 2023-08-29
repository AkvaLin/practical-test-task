//
//  NetworkService.swift
//  PracticalTestTask
//
//  Created by Никита Пивоваров on 28.08.2023.
//

import Foundation
import Combine

enum NetworkService {
    enum FailureReason : Error {
        case wrongURL
        case sessionFailed(error: URLError)
        case decodingFailed
        case other(Error)
    }
    
    static func request<SomeDecodable: Decodable>(_ someDecodable: SomeDecodable.Type, url: URL) -> AnyPublisher<SomeDecodable, FailureReason> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { element -> Data in
               guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                  throw URLError(.badServerResponse)
               }
               return element.data
            }
            .decode(type: SomeDecodable.self, decoder: JSONDecoder())
            .mapError({ error in
                switch error {
                case is Swift.DecodingError:
                    return .decodingFailed
                case let urlError as URLError:
                    return .sessionFailed(error: urlError)
                default:
                    return .other(error)
                }
            })
            .eraseToAnyPublisher()
    }
}
