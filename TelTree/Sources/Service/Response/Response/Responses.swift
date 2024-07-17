import Foundation

struct TokenResponse: Decodable {
    let access_token: String
}

struct FetchDonationResponse: Codable {
    let post: Post
}

// MARK: - Post
struct Post: Codable {
    let writer: Writer
    let cartegory, title, explanation, address: String
    let contact, startDate, endDate, img: String
}

// MARK: - Writer
struct Writer: Codable {
    let username, profile, email: String
}
