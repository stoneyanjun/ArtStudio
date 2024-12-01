//
//  MockCoreDataClient.swift
//  ArtStudio
//
//  Created by stone on 2024/12/5.
//

import XCTest
import ComposableArchitecture
@testable import ArtStudio

struct MockCoreDataClient: CoreDataClientProtocol {
    private var storedDate: Date?

    func loadFetchedTopicDate() -> Date? {
        storedDate
    }

    func updateFetchedTopicDate(to newDate: Date) {
    }
}
