//
//  Parameters.swift
//  ArtStudio
//
//  Created by stone on 2024/11/27.
//

import Foundation

enum ArtColor: String {
    case black_and_white
    case black
    case white
    case yellow
    case orange
    case red
    case purple
    case magenta
    case green
    case teal
    case blue
}

enum ContentFilter: String {
    case low
    case high
}

enum ArtOrientation: String {
    case landscape
    case portrait
    case squarish
}

enum OrderBy: String {
    case relevant
    case latest
}

struct SearchPhotoParam {
    let query: String
    let page: Int
    var orderBy: OrderBy?
    var collectionIDs: [String]?
    var contentFilter: ContentFilter?
    var color: ArtColor?
    var orientation: ArtOrientation?
}
