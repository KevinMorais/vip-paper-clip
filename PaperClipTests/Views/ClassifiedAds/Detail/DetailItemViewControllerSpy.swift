//
//  DetailItemViewControllerSpy.swift
//  PaperClip
//
//  Created by Kevin Morais on 06/08/2022.
//  
//

import XCTest
@testable import PaperClip

final class DetailItemViewControllerSpy: DetailItemViewControllerInput {

    var invokedDisplay = false
    var invokedDisplayCount = 0
    var invokedDisplayParameters: (viewModel: DetailItemViewModel.Content, Void)?
    var invokedDisplayParametersList = [(viewModel: DetailItemViewModel.Content, Void)]()

    func display(_ viewModel: DetailItemViewModel.Content) {
        invokedDisplay = true
        invokedDisplayCount += 1
        invokedDisplayParameters = (viewModel, ())
        invokedDisplayParametersList.append((viewModel, ()))
    }

    var invokedDisplayRetryHandler = false
    var invokedDisplayRetryHandlerCount = 0
    var invokedDisplayRetryHandlerParameters: (error: Error, Void)?
    var invokedDisplayRetryHandlerParametersList = [(error: Error, Void)]()
    var shouldInvokeDisplayRetryHandlerRetryHandler = false

    func display(_ error: Error, retryHandler: (() -> Void)?) {
        invokedDisplayRetryHandler = true
        invokedDisplayRetryHandlerCount += 1
        invokedDisplayRetryHandlerParameters = (error, ())
        invokedDisplayRetryHandlerParametersList.append((error, ()))
        if shouldInvokeDisplayRetryHandlerRetryHandler {
            retryHandler?()
        }
    }
}
