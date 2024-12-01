//
//  DateClient.swift
//  ArtStudio
//
//  Created by stone on 2024/12/1.
//

import Foundation
import ComposableArchitecture

struct DateClient {
    var now: () -> Date
}

extension DependencyValues {
    var dateClient: DateClient {
        get { self[DateClient.self] }
        set { self[DateClient.self] = newValue }
    }
}

extension DateClient: DependencyKey {
    static let liveValue = DateClient(now: { Date() })
    static let mockValue = DateClient(now: { Date(timeIntervalSince1970: 0) }) // Mock date: Jan 1, 1970
}
