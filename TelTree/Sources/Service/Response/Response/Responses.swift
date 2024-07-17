import Foundation

struct TokenResponse: Decodable {
    let access: String
}

//struct FetchDonationResponse: Codable {
//    let post: Post
//}
//
//// MARK: - Post
//struct Post: Codable {
//    let writer: Writer
//    let cartegory, title, explanation, address: String
//    let contact, startDate, endDate, img: String
//}
//
//// MARK: - Writer
//struct Writer: Codable {
//    let username, profile, email: String
//}

struct MainpageResponse: Codable {
    let posts: Post
    
    init(posts: Post) {
        self.posts = posts
    }
}

struct Post: Codable {
    let postID: Int
    let title, address, startDate, endDate, imageURL: String

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case title, address
        case startDate = "start_date"
        case endDate = "end_date"
        case imageURL = "image_url"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.postID = try container.decode(Int.self, forKey: .postID)
        self.title = try container.decode(String.self, forKey: .title)
        self.address = try container.decode(String.self, forKey: .address)
        self.startDate = try container.decode(String.self, forKey: .startDate)
        self.endDate = try container.decode(String.self, forKey: .endDate)
        self.imageURL = try container.decode(String.self, forKey: .imageURL)
    }
}
