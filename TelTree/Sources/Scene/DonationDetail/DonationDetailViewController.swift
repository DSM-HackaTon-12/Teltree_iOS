import UIKit
import Moya
import SnapKit
import Then
import Kingfisher

class DonationDetailViewController: BaseViewController {
    var postId: Int = 0
    private let provider = MoyaProvider<PostAPI>(plugins: [MoyaLoggingPlugin()])
    
    let titleImage = UIImageView().then {
        $0.backgroundColor = .gray
    }
    
    let profileImage = UIImageView().then {
        $0.layer.cornerRadius = 30
        $0.layer.masksToBounds = true
        $0.backgroundColor = .gray
    }
    
    let profileLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 14)
    }
    
    let line = UIView().then {
        $0.backgroundColor = TelTreeAsset.gray200.color
    }
    
    let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .medium)
        $0.numberOfLines = 3
    }
    
    let quotation = UIView().then {
        $0.backgroundColor = TelTreeAsset.gray400.color
    }
    
    let addressLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .light)
        $0.textColor = TelTreeAsset.gray400.color
    }
    
    let dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .light)
    }
    
    let phoneLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .light)
    }
    
    let detailLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .light)
        $0.numberOfLines = 0
    }
    
    let applyButton = UIButton().then {
        $0.setTelTreeButton(setTitle: "신청하기")
        $0.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
    }
    
    @objc func applyButtonTapped() {
        provider.request(.apply(postId: self.postId, token: Token.accessToken ?? "")) { result in
            switch result {
            case .success:
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                print(error)
            }
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        provider.request(.detail(postId: self.postId, token: Token.accessToken ?? "")) { result in
            switch result {
            case .success(let response):
                do {
                    let reponseData = try JSONDecoder().decode(FetchDonationResponse.self, from: response.data)
                    self.titleImage.kf.setImage(with: URL(string: reponseData.post.img))
                    self.profileImage.kf.setImage(with: URL(string: reponseData.post.writer.profile))
                    self.profileLabel.text = reponseData.post.writer.username
                    self.titleLabel.text = reponseData.post.title
                    self.addressLabel.text = reponseData.post.address
                    self.dateLabel.text = "\(reponseData.post.startDate) ~ \(reponseData.post.endDate)"
                    self.phoneLabel.text = reponseData.post.contact
                    self.detailLabel.text = reponseData.post.content
                } catch let error {
                    print(error)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }


    override func configureViewController() {
        self.tabBarController?.tabBar.isHidden = true
    }
    override func addView() {
        [
            titleImage,
            profileImage,
            profileLabel,
            line,
            titleLabel,
            quotation,
            addressLabel,
            dateLabel,
            phoneLabel,
            detailLabel,
            applyButton
        ].forEach{ view.addSubview($0) }
    }
    
    override func setLayout() {
        titleImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(253)
        }
        profileImage.snp.makeConstraints {
            $0.top.equalTo(titleImage.snp.bottom).offset(12)
            $0.left.equalToSuperview().inset(21)
            $0.height.width.equalTo(60)
        }
        profileLabel.snp.makeConstraints {
            $0.top.equalTo(titleImage.snp.bottom).offset(32)
            $0.left.equalTo(profileImage.snp.right).offset(15)
        }
        line.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(21)
            $0.height.equalTo(1)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(line.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(21)
        }
        quotation.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.top).offset(-6)
            $0.left.equalToSuperview().inset(21)
            $0.width.equalTo(1)
            $0.bottom.equalTo(phoneLabel.snp.bottom).offset(6)
        }
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.left.equalTo(quotation.snp.right).offset(15)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(3)
            $0.left.equalTo(quotation.snp.right).offset(15)
        }
        phoneLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(3)
            $0.left.equalTo(quotation.snp.right).offset(15)
        }
        detailLabel.snp.makeConstraints {
            $0.top.equalTo(quotation.snp.bottom).offset(22)
            $0.left.right.equalToSuperview().inset(21)
        }
        applyButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(37)
            $0.left.right.equalToSuperview().inset(31)
            $0.height.equalTo(50)
        }
    }
}
