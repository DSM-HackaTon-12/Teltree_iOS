import UIKit
import SnapKit
import Then

class ReviewTableCell: UITableViewCell {
    static let identifier = "ReviewTableViewCell"
    
    let donationImageView = UIImageView().then {
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.backgroundColor = .gray
    }
    let titleLabel = UILabel().then {
        $0.text = "해커톤 하는데 mc봐주실분"
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.numberOfLines = 2
    }
    let addressLabel = UILabel().then {
        $0.text = "달나라"
        $0.font = .systemFont(ofSize: 12, weight: .thin)
    }
    let periodLabel = UILabel().then {
        $0.text = "3099.07.16 ~ 3199.07.19"
        $0.font = .systemFont(ofSize: 14)
    }
    let reviewButton = UIButton().then {
        $0.setTelTreeButton(setTitle: "리뷰 작성하러 가기")
    }

    override func layoutSubviews() {
        [
          donationImageView,
          titleLabel,
          addressLabel,
          periodLabel,
          reviewButton
        ].forEach{ addSubview($0) }
        
        donationImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
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
        reviewButton.snp.makeConstraints {
            $0.top.equalTo(donationImageView.snp.bottom).offset(12)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}
