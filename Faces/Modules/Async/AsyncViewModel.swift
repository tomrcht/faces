//
//  AsyncViewModel.swift
//  Faces
//
//  Created by Tom Rochat on 29/11/2021.
//

import Foundation
import Combine
import UIKit

final class AsyncViewModel: ConnectedViewModel {
    let isLoading = CurrentValueSubject<Bool, Never>(false)
    let currentQuote = CurrentValueSubject<KanyeQuote?, Never>(nil)
    let currentError = CurrentValueSubject<Error?, Never>(nil)

    var bag = Set<AnyCancellable>()

    private let kanyeService: KanyeService

    init(kanyeService: KanyeService) {
        self.kanyeService = kanyeService
    }

    func getNewQuote() {
        currentError.send(nil)
        isLoading.send(true)

        Task {
            do {
                let quote = try await kanyeService.quote()
                currentQuote.send(quote)
            } catch {
                currentQuote.send(nil)
                currentError.send(error)
            }
            isLoading.send(false)
        }
    }
}
