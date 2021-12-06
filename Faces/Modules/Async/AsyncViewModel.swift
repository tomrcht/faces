//
//  AsyncViewModel.swift
//  Faces
//
//  Created by Tom Rochat on 29/11/2021.
//

import Foundation
import Combine

final class AsyncViewModel: ConnectedViewModel {
    let isLoading = CurrentValueSubject<Bool, Never>(false)
    let currentQuote = CurrentValueSubject<KanyeQuote?, Never>(nil)
    let currentError = CurrentValueSubject<Error?, Never>(nil)

    var bag = Set<AnyCancellable>()

    let builder: AsyncBuilder
    private let kanyeService: KanyeService

    init(builder: AsyncBuilder, kanyeService: KanyeService) {
        self.builder = builder
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
