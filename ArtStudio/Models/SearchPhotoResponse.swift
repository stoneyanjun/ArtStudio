// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let searchPhoto = try? JSONDecoder().decode(SearchPhoto.self, from: jsonData)

import Foundation

// MARK: - SearchPhoto
struct SearchPhotoResponse: Codable, Equatable, Hashable  {
    let localID = UUID()
    static func == (lhs: SearchPhotoResponse, rhs: SearchPhotoResponse) -> Bool {
        lhs.localID == rhs.localID
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(localID)
    }
    
    let total, totalPages: Int?
    let results: [ArtPhoto]?
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}
