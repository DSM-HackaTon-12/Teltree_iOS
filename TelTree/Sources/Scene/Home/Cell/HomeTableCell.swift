import UIKit
import SnapKit
import Then
import Moya
import Kingfisher

class HomeTableViewCell: UITableViewCell {
    var postId: Int = 0
    private let manager: Session = Session(configuration: URLSessionConfiguration.default, serverTrustManager: CustomServerTrustManager())
    private lazy var provider = MoyaProvider<PostAPI>(session: manager, plugins: [MoyaLoggingPlugin()])
    
    static let identifier = "HomeTableViewCell"
    let donationImageView = UIImageView().then {
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.numberOfLines = 2
    }
    let addressLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .thin)
    }
    let periodLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
    }

    override func layoutSubviews() {
        [
          donationImageView,
          titleLabel,
          addressLabel,
          periodLabel
        ].forEach{ addSubview($0) }
        
        donationImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview().inset(12)
            $0.left.equalToSuperview()
            $0.width.height.equalTo(110)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.left.equalTo(donationImageView.snp.right).offset(10)
            $0.right.equalToSuperview()
        }
        addressLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(58)
            $0.left.equalTo(donationImageView.snp.right).offset(10)
            $0.right.equalToSuperview()
        }
        periodLabel.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(5)
            $0.left.equalTo(donationImageView.snp.right).offset(10)
            $0.right.equalToSuperview()
        }
    }
    
    func setup(image: String, title: String, subTitle: String, data: String, postId: Int) {
        donationImageView.kf.setImage(with: URL(string: image))
        titleLabel.text = title
        addressLabel.text = subTitle
        periodLabel.text = data
        self.postId = postId
    }
}
