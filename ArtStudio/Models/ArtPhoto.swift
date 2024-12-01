// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let artPhoto = try? JSONDecoder().decode(ArtPhoto.self, from: jsonData)

import Foundation

// MARK: - ArtPhoto
struct ArtPhoto: Codable, Equatable, Hashable, Identifiable  {
    let localID = UUID()
    static func == (lhs: ArtPhoto, rhs: ArtPhoto) -> Bool {
        lhs.localID == rhs.localID
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(localID)
    }
    
    let slug, color: String?
    let location: Location?
    let likes: Int?
    let tags: [Tag]?
    let assetType: AssetType?
    let downloads: Int?
    let updatedAt: Date?
    let publicDomain: Bool?
    let views: Int?
    let links: ArtPhotoLinks?
    let relatedCollections: RelatedCollections?
    let meta: Meta?
    let id: String?
    let topicSubmissions: TopicSubmissions?
    let likedByUser: Bool?
    let user: User?
    let exif: Exif?
    let alternativeSlugs: AlternativeSlugs?
    let promotedAt: Date?
    let height, width: Int?
    let urls: Urls?
    let createdAt: Date?
    let blurHash, altDescription: String?
    let sponsorship: Sponsorship?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case slug, color, location, likes, tags
        case assetType = "asset_type"
        case downloads
        case updatedAt = "updated_at"
        case publicDomain = "public_domain"
        case views, links
        case relatedCollections = "related_collections"
        case meta, id
        case topicSubmissions = "topic_submissions"
        case likedByUser = "liked_by_user"
        case user, exif
        case alternativeSlugs = "alternative_slugs"
        case promotedAt = "promoted_at"
        case height, width, urls
        case createdAt = "created_at"
        case blurHash = "blur_hash"
        case altDescription = "alt_description"
        case sponsorship, description
    }
    
    // MARK: - AlternativeSlugs
    struct AlternativeSlugs: Codable {
        let fr, ko, pt, it: String?
        let de, es, en, ja: String?
    }
    
    enum AssetType: String, Codable {
        case photo = "photo"
    }
    
    // MARK: - Exif
    struct Exif: Codable {
        let make, focalLength, aperture: String?
        let iso: Int?
        let model, exposureTime, name: String?
        
        enum CodingKeys: String, CodingKey {
            case make
            case focalLength = "focal_length"
            case aperture, iso, model
            case exposureTime = "exposure_time"
            case name
        }
    }
    
    // MARK: - ArtPhotoLinks
    struct ArtPhotoLinks: Codable {
        let downloadLocation, linksSelf, html, download: String?
        
        enum CodingKeys: String, CodingKey {
            case downloadLocation = "download_location"
            case linksSelf = "self"
            case html, download
        }
    }
    
    // MARK: - Location
    struct Location: Codable {
        let country, name, city: String?
        let position: Position?
    }
    
    // MARK: - Position
    struct Position: Codable {
        let longitude, latitude: Int?
    }
    
    // MARK: - Meta
    struct Meta: Codable {
        let index: Bool?
    }
    
    // MARK: - RelatedCollections
    struct RelatedCollections: Codable {
        let total: Int?
        let type: String?
        let results: [Result]?
    }
    
    // MARK: - Result
    struct Result: Codable {
        let id, description: String?
        let publishedAt: Date?
        let resultPrivate: Bool?
        let shareKey: String?
        let coverPhoto: CoverPhoto?
        let featured: Bool?
        let tags: [Tag]?
        let lastCollectedAt: Date?
        let title: String?
        let previewPhotos: [PreviewPhoto]?
        let updatedAt: Date?
        let links: ResultLinks?
        let user: User?
        let totalPhotos: Int?
        
        enum CodingKeys: String, CodingKey {
            case id, description
            case publishedAt = "published_at"
            case resultPrivate = "private"
            case shareKey = "share_key"
            case coverPhoto = "cover_photo"
            case featured, tags
            case lastCollectedAt = "last_collected_at"
            case title
            case previewPhotos = "preview_photos"
            case updatedAt = "updated_at"
            case links, user
            case totalPhotos = "total_photos"
        }
    }
    
    // MARK: - CoverPhoto
    struct CoverPhoto: Codable {
        let slug, color: String?
        let likes: Int?
        let assetType: AssetType?
        let updatedAt: Date?
        let links: ArtPhotoLinks?
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
    
    // MARK: - TopicSubmissions
    struct TopicSubmissions: Codable {
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
    
    // MARK: - ResultLinks
    struct ResultLinks: Codable {
        let photos, linksSelf, html, related: String?
        
        enum CodingKeys: String, CodingKey {
            case photos
            case linksSelf = "self"
            case html, related
        }
    }
    
    // MARK: - PreviewPhoto
    struct PreviewPhoto: Codable {
        let slug, blurHash: String?
        let urls: Urls?
        let id: String?
        let createdAt: Date?
        let assetType: AssetType?
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
    
    // MARK: - Tag
    struct Tag: Codable {
        let type: TypeEnum?
        let title: String?
    }
    
    enum TypeEnum: String, Codable {
        case search = "search"
    }
    
    // MARK: - Sponsorship
    struct Sponsorship: Codable {
        let taglineURL: String?
        let sponsor: User?
        let impressionUrls: [String]?
        let tagline: String?
        
        enum CodingKeys: String, CodingKey {
            case taglineURL = "tagline_url"
            case sponsor
            case impressionUrls = "impression_urls"
            case tagline
        }
    }
}
