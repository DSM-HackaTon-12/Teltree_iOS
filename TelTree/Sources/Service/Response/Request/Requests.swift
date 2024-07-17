import Foundation

struct RegisterRequest: Codable {
    let title, content, address, contact, startDate, endDate, imageURL: String

    enum CodingKeys: String, CodingKey {
        case title, content, address, contact
        case startDate = "start_date"
        case endDate = "end_date"
        case imageURL = "image_url"
    }
}
