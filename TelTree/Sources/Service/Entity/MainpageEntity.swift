import Foundation

struct MainpageEntity {
    let postID: Int
    let title, address, startDate, endDate, imageURL: String

    init(postID: Int, title: String, address: String, startDate: String, endDate: String, imageURL: String) {
        self.postID = postID
        self.title = title
        self.address = address
        self.startDate = startDate
        self.endDate = endDate
        self.imageURL = imageURL
    }
}
