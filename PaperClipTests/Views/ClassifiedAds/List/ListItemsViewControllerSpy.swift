//
//  ListItemsViewControllerSpy.swift
//  PaperClip
//
//  Created by Kevin Morais on 06/08/2022.
//  
//

import XCTest
@testable import PaperClip

final class ListItemsViewControllerSpy: ListItemsViewControllerInput {

    var invokedDisplay = false
    var invokedDisplayCount = 0
    var invokedDisplayParameters: (viewModel: ListItemsViewModel.Content, Void)?
    var invokedDisplayParametersList = [(viewModel: ListItemsViewModel.Content, Void)]()

    func display(_ viewModel: ListItemsViewModel.Content) {
        invokedDisplay = true
        invokedDisplayCount += 1
        invokedDisplayParameters = (viewModel, ())
        invokedDisplayParametersList.append((viewModel, ()))
    }

    var invokedDisplayDetail = false
    var invokedDisplayDetailCount = 0

    func displayDetail() {
        invokedDisplayDetail = true
        invokedDisplayDetailCount += 1
    }

    var invokedRetry = false
    var invokedRetryCount = 0

    func retry() {
        invokedRetry = true
        invokedRetryCount += 1
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


