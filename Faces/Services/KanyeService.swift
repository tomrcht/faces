//
//  KanyeService.swift
//  Faces
//
//  Created by Tom Rochat on 06/12/2021.
//

import Foundation

final class KanyeService {
    private let url = URL(string: "https://api.kanye.rest")!
    private let session = URLSession.shared
    private let decoder = JSONDecoder()

    init() {

    }

    func quote() async throws -> KanyeQuote {
        let request = URLRequest(url: url)
        let (data, _) = try await session.data(for: request)

        guard let formattedData = try? decoder.decode(KanyeQuote.self, from: data) else {
            throw Error.decode
        }

        return formattedData
    }
}

// MARK: - Errors
extension KanyeService {
    enum Error: LocalizedError {
        case decode

        var errorDescription: String? {
            switch self {
            case .decode:
                return "Could not decode the response"
            }
        }
    }
}
