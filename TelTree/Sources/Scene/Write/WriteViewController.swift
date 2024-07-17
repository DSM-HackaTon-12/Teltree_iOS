import UIKit
import Moya
import Alamofire
import SnapKit
import Then

class WriteViewController: BaseViewController {
    
    private let manager: Session = Session(configuration: URLSessionConfiguration.default, serverTrustManager: CustomServerTrustManager())
    private lazy var provider = MoyaProvider<PostAPI>(session: manager, plugins: [MoyaLoggingPlugin()])
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    let imageButton = UIButton().then {
        $0.setTitle("사진 추가하기", for: .normal)
        $0.setTitleColor(TelTreeAsset.gray300.color, for: .normal)
        $0.addTarget(self, action: #selector(selectImageTapped), for: .touchUpInside)
    }
    var imageURL = ""
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
        }
        
        if let imageUrl = info[.imageURL] as? URL {
            print("Selected image URL: \(imageUrl)")
            imageURL = "\(imageUrl)"
        }
        
        dismiss(animated: true, completion: nil)
    }
    @objc func selectImageTapped() {
        let imagePicker = UIImagePickerController().then {
            $0.delegate = self
            $0.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
    let backButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    @objc func backButtonTapped() {
        self.dismiss(animated: true)
    }
    
    let titleLabel = UILabel().then {
        $0.text = "제목"
    }
    let titleField = UITextField().then {
        $0.setTelTreeTextField(placeholder: "제목을 작성해 주세요", radius: 8)
    }
    let addressLabel = UILabel().then {
        $0.text = "장소"
    }
    let addressField = UITextField().then {
        $0.setTelTreeTextField(placeholder: "장소를 작성해 주세요", radius: 8)
    }
    let dateLabel = UILabel().then {
        $0.text = "날짜"
    }
    let dateStartField = UITextField().then {
        $0.setTelTreeTextField(placeholder: "YYYY-MM-DD")
    }
    let mLabel = UILabel().then {
        $0.text = "~"
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = TelTreeAsset.gray400.color
    }
    let dateEndField = UITextField().then {
        $0.setTelTreeTextField(placeholder: "YYYY-MM-DD")
    }
    let phoneLabel = UILabel().then {
        $0.text = "연락처"
    }
    let phoneField = UITextField().then {
        $0.setTelTreeTextField(placeholder: "연락처를 작성해 주세요", radius: 8)
    }
    let detailLabel = UILabel().then {
        $0.text = "내용"
    }
    let detailTextView = UITextView().then {
        $0.backgroundColor = TelTreeAsset.gray100.color
        $0.layer.borderWidth = 1
        $0.layer.borderColor = TelTreeAsset.gray200.color.cgColor
        $0.layer.cornerRadius = 8
        $0.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15);
    }
    let completedButton = UIButton().then {
        $0.setTelTreeButton(setTitle: "작성완료")
        $0.addTarget(self, action: #selector(completedButtonTapped), for: .touchUpInside)
        $0.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc func completedButtonTapped() {
        DispatchQueue.main.async {
            print("버튼 클릭 토큰 확인 : \(Token.accessToken)")
            self.provider.request(.register(request: RegisterRequest(title: self.titleField.text!, content: self.detailTextView.text!, address: self.addressField.text!, contact: self.phoneField.text!, startDate: self.dateStartField.text!, endDate: self.dateEndField.text!, imageURL: self.imageURL), token: Token.accessToken ?? "")) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodeResponse = try JSONDecoder().decode(TokenResponse.self, from: response.data)
                        self.dismiss(animated: true)
                    } catch let error {
                        guard let error = error as? MoyaError else { return }
                        print(error.response?.statusCode)
                    }
                case .failure(let error):
                    guard let error = error as? MoyaError else { return }
                    print(error.response?.statusCode)
                }
            }
        }
    }
    
    override func addView() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        [
            imageView,
            imageButton,
            backButton,
            titleLabel,
            titleField,
            addressLabel,
            addressField,
            dateLabel,
            dateStartField,
            mLabel,
            dateEndField,
            phoneLabel,
            phoneField,
            detailLabel,
            detailTextView,
            completedButton
        ].forEach(self.contentView.addSubview(_:))
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.equalTo(completedButton.snp.bottom).offset(31)
        }
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(253)
        }
        imageButton.snp.makeConstraints {
            $0.bottom.equalTo(imageView.snp.bottom).inset(12)
            $0.right.equalToSuperview().inset(20)
        }
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.left.equalToSuperview().inset(21)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(15)
            $0.left.equalToSuperview().inset(21)
        }
        titleField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.left.right.equalToSuperview().inset(21)
            $0.height.equalTo(50)
        }
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(titleField.snp.bottom).offset(15)
            $0.left.equalToSuperview().inset(21)
        }
        addressField.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(3)
            $0.left.right.equalToSuperview().inset(21)
            $0.height.equalTo(50)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(addressField.snp.bottom).offset(15)
            $0.left.equalToSuperview().inset(21)
        }
        dateStartField.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(3)
            $0.right.equalTo(mLabel.snp.left).offset(-19)
            $0.width.equalTo(150)
            $0.height.equalTo(50)
        }
        mLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(dateStartField.snp.top).offset(13)
        }
        dateEndField.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(3)
            $0.left.equalTo(mLabel.snp.right).offset(19)
            $0.width.equalTo(150)
            $0.height.equalTo(50)
        }
        phoneLabel.snp.makeConstraints {
            $0.top.equalTo(dateStartField.snp.bottom).offset(15)
            $0.left.equalToSuperview().inset(21)
        }
        phoneField.snp.makeConstraints {
            $0.top.equalTo(phoneLabel.snp.bottom).offset(3)
            $0.left.right.equalToSuperview().inset(21)
            $0.height.equalTo(50)
        }
        detailLabel.snp.makeConstraints {
            $0.top.equalTo(phoneField.snp.bottom).offset(15)
            $0.left.equalToSuperview().inset(21)
        }
        detailTextView.snp.makeConstraints {
            $0.top.equalTo(detailLabel.snp.bottom).offset(3)
            $0.left.right.equalToSuperview().inset(21)
            $0.height.equalTo(200)
        }
        completedButton.snp.makeConstraints {
            $0.top.equalTo(detailTextView.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(31)
            $0.height.equalTo(50)
        }
    }
}

extension WriteViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
}
