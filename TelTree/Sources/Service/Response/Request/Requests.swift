import Foundation

struct RegisterRequest: Encodable {
    let post: PostRequest

    init(post: PostRequest) {
        self.post = post
    }

}
struct PostRequest: Encodable {
    let cartegory, title, explanation, address, contact, startDate, endDate, img: String

    init(cartegory: String, title: String, explanation: String, address: String, contact: String, startDate: String, endDate: String, img: String) {
        self.cartegory = cartegory
        self.title = title
        self.explanation = explanation
        self.address = address
        self.contact = contact
        self.startDate = startDate
        self.endDate = endDate
        self.img = img
    }
}
