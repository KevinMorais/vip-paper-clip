//
//  APIConfiguration.swift
//  
//
//  Created by Kevin Morais on 05/08/2022.
//

import Foundation

public struct APIConfiguration {

    // swiftlint:disable all force_unwrapping
    private enum Constants {
        static let domain: URL = .init(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master")!
        static let rangeSuccessCode: ClosedRange<Int> = (200...299)
        static let responseQueue: DispatchQueue = .main
    }

    let baseURL: URL = Constants.domain
    let rangeSuccessCode: ClosedRange<Int> = Constants.rangeSuccessCode
    let responseQueue: DispatchQueue = Constants.responseQueue

    public init() {}
}
