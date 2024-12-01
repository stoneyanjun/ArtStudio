// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let artTopic = try? JSONDecoder().decode(ArtTopic.self, from: jsonData)

import Foundation

// MARK: - ArtTopic
struct ArtTopic: Codable, Equatable, Hashable, Identifiable  {
    let localID = UUID()
    static func == (lhs: ArtTopic, rhs: ArtTopic) -> Bool {
        lhs.localID == rhs.localID
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(localID)
    }

    let slug, status, title: String?
    let publishedAt, updatedAt: Date?
    let visibility: String?
    let endsAt: Date?
    let totalPhotos: Int?
    let links: ArtTopicLinks?
    let previewPhotos: [PreviewPhoto]?
    let coverPhoto: CoverPhoto?
    let id, onlySubmissionsAfter: String?
    let mediaTypes: [String]?
    let totalCurrentUserSubmissions: String?
    let startsAt: Date?
    let featured: Bool?
    let owners: [User]?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case slug, status, title
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
        case visibility
        case endsAt = "ends_at"
        case totalPhotos = "total_photos"
        case links
        case previewPhotos = "preview_photos"
        case coverPhoto = "cover_photo"
        case id
        case onlySubmissionsAfter = "only_submissions_after"
        case mediaTypes = "media_types"
        case totalCurrentUserSubmissions = "total_current_user_submissions"
        case startsAt = "starts_at"
        case featured, owners, description
    }
    
    // MARK: - CoverPhoto
    struct CoverPhoto: Codable {
        let slug, color: String?
        let likes: Int?
        let assetType: String?
        let updatedAt: Date?
        let links: CoverPhotoLinks?
        let id: String?
        let topicSubmissions: TopicSubmissions?
        let likedByUser: Bool?
        let user: User?
        let alternativeSlugs: AlternativeSlugs?
        let promotedAt: Date?
        let height, width: Int?
        let urls: Urls?
        let createdAt: Date?
        let blurHash, altDescription, sponsorship, description: String?
        
        enum CodingKeys: String, CodingKey {
            case slug, color, likes
            case assetType = "asset_type"
            case updatedAt = "updated_at"
            case links, id
            case topicSubmissions = "topic_submissions"
            case likedByUser = "liked_by_user"
            case user
            case alternativeSlugs = "alternative_slugs"
            case promotedAt = "promoted_at"
            case height, width, urls
            case createdAt = "created_at"
            case blurHash = "blur_hash"
            case altDescription = "alt_description"
            case sponsorship, description
        }
    }
    
    // MARK: - AlternativeSlugs
    struct AlternativeSlugs: Codable {
        let fr, ko, pt, it: String?
        let de, es, en, ja: String?
    }
    
    // MARK: - CoverPhotoLinks
    struct CoverPhotoLinks: Codable {
        let downloadLocation, linksSelf, html, download: String?
        
        enum CodingKeys: String, CodingKey {
            case downloadLocation = "download_location"
            case linksSelf = "self"
            case html, download
        }
    }
    
    // MARK: - TopicSubmissions
    struct TopicSubmissions: Codable {
        let night, architectureInterior: ArchitectureInterior?
        
        enum CodingKeys: String, CodingKey {
            case night
            case architectureInterior = "architecture-interior"
        }
    }
    
    // MARK: - ArchitectureInterior
    struct ArchitectureInterior: Codable {
        let status: String?
        let approvedOn: Date?
        
        enum CodingKeys: String, CodingKey {
            case status
            case approvedOn = "approved_on"
        }
    }
    
    // MARK: - Urls
    struct Urls: Codable {
        let raw, full, thumb, smallS3: String?
        let regular, small: String?
        
        enum CodingKeys: String, CodingKey {
            case raw, full, thumb
            case smallS3 = "small_s3"
            case regular, small
        }
    }
    
    // MARK: - User
    struct User: Codable {
        let profileImage: ProfileImage?
        let location: String?
        let updatedAt: Date?
        let twitterUsername: String?
        let totalCollections: Int?
        let lastName, bio, name: String?
        let links: UserLinks?
        let totalLikes, totalPhotos, totalIllustrations: Int?
        let id: String?
        let totalPromotedPhotos: Int?
        let forHire: Bool?
        let social: Social?
        let portfolioURL: String?
        let acceptedTos: Bool?
        let firstName, instagramUsername: String?
        let totalPromotedIllustrations: Int?
        let username: String?
        
        enum CodingKeys: String, CodingKey {
            case profileImage = "profile_image"
            case location
            case updatedAt = "updated_at"
            case twitterUsername = "twitter_username"
            case totalCollections = "total_collections"
            case lastName = "last_name"
            case bio, name, links
            case totalLikes = "total_likes"
            case totalPhotos = "total_photos"
            case totalIllustrations = "total_illustrations"
            case id
            case totalPromotedPhotos = "total_promoted_photos"
            case forHire = "for_hire"
            case social
            case portfolioURL = "portfolio_url"
            case acceptedTos = "accepted_tos"
            case firstName = "first_name"
            case instagramUsername = "instagram_username"
            case totalPromotedIllustrations = "total_promoted_illustrations"
            case username
        }
    }
    
    // MARK: - UserLinks
    struct UserLinks: Codable {
        let photos, following, portfolio, html: String?
        let followers, linksSelf, likes: String?
        
        enum CodingKeys: String, CodingKey {
            case photos, following, portfolio, html, followers
            case linksSelf = "self"
            case likes
        }
    }
    
    // MARK: - ProfileImage
    struct ProfileImage: Codable {
        let small, large, medium: String?
    }
    
    // MARK: - Social
    struct Social: Codable {
        let instagramUsername, paypalEmail: String?
        let portfolioURL: String?
        let twitterUsername: String?
        
        enum CodingKeys: String, CodingKey {
            case instagramUsername = "instagram_username"
            case paypalEmail = "paypal_email"
            case portfolioURL = "portfolio_url"
            case twitterUsername = "twitter_username"
        }
    }
    
    // MARK: - ArtTopicLinks
    struct ArtTopicLinks: Codable {
        let photos, html, linksSelf: String?
        
        enum CodingKeys: String, CodingKey {
            case photos, html
            case linksSelf = "self"
        }
    }
    
    // MARK: - PreviewPhoto
    struct PreviewPhoto: Codable {
        let slug, blurHash: String?
        let urls: Urls?
        let id: String?
        let createdAt: Date?
        let assetType: String?
        let updatedAt: Date?
        
        enum CodingKeys: String, CodingKey {
            case slug
            case blurHash = "blur_hash"
            case urls, id
            case createdAt = "created_at"
            case assetType = "asset_type"
            case updatedAt = "updated_at"
        }
    }
}
