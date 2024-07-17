import Foundation

struct TokenResponse: Decodable {
    let access: String
}

struct FetchDonationResponse: Codable {
    let post: PostData
}

// MARK: - Post
struct PostData: Codable {
    let writer: Writer
    let title, content, address: String
    let contact, startDate, endDate, img: String
}

// MARK: - Writer
struct Writer: Codable {
    let username, profile, email: String
}

struct MainpageResponse: Decodable {
    let posts: [Post]
}

struct Post: Decodable {
    let postID: Int
    let title, address, startDate, endDate, imageURL: String

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case title, address
        case startDate = "start_date"
        case endDate = "end_date"
        case imageURL = "image_url"
    }
}

extension Post {
    func toEntity() -> MainpageEntity {
        return .init(
            postID: self.postID,
            title: self.title,
            address: self.address,
            startDate: self.startDate,
            endDate: self.endDate,
            imageURL: self.imageURL
        )
    }
}
