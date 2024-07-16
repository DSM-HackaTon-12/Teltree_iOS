import UIKit
import SnapKit
import Then

class MainViewController: BaseViewController {
    
    let loginLabel = UILabel().then {
        $0.text = "로그인"
        $0.font = .systemFont(ofSize: 30)
    }
    
    let emailLabel = UILabel().then {
        $0.text = "이메일"
    }
    
    let emailField = UITextField().then {
        $0.placeholder = "이메일을 입력해 주세요"
        $0.backgroundColor = TelTreeAsset.gray100.color
        $0.layer.borderWidth = 1
        $0.layer.borderColor = TelTreeAsset.gray200.color.cgColor
        $0.layer.cornerRadius = 25
        $0.addLeftPadding()
    }
    
    let pwdLabel = UILabel().then {
        $0.text = "비밀번호"
    }
    
    let pwdField = UITextField().then {
        $0.placeholder = "비밀번호를 입력해 주세요"
        $0.backgroundColor = TelTreeAsset.gray100.color
        $0.layer.borderWidth = 1
        $0.layer.borderColor = TelTreeAsset.gray200.color.cgColor
        $0.layer.cornerRadius = 25
        $0.isSecureTextEntry = true
        $0.addLeftPadding()
    }
    
    let loginButton = UIButton(type: .system).then {
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = TelTreeAsset.green200.color
        $0.layer.cornerRadius = 25
        $0.tintColor = .white
    }
    
    let loginCheckLabel = UILabel().then {
        $0.text = "계정이 없으신가요?"
        $0.font = .systemFont(ofSize: 16, weight: .thin)
    }
    
    let signupButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .thin)
        $0.setTitleColor(TelTreeAsset.blue.color, for: .normal)
        $0.setUnderline()
    }
    
    override func addView() {
        [
            loginLabel,
            emailLabel,
            emailField,
            pwdLabel,
            pwdField,
            loginButton,
            loginCheckLabel,
            signupButton
        ].forEach { view.addSubview($0) }
    }
    override func setLayout() {
        loginLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(118)
            $0.left.equalToSuperview().offset(31)
        }
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(35)
            $0.left.equalToSuperview().offset(31)
        }
        emailField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(6)
            $0.left.right.equalToSuperview().inset(31)
            $0.height.equalTo(50)
        }
        pwdLabel.snp.makeConstraints {
            $0.top.equalTo(emailField.snp.bottom).offset(35)
            $0.left.equalToSuperview().offset(31)
        }
        pwdField.snp.makeConstraints {
            $0.top.equalTo(pwdLabel.snp.bottom).offset(6)
            $0.left.right.equalToSuperview().inset(31)
            $0.height.equalTo(50)
        }
        loginButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(144)
            $0.left.right.equalToSuperview().inset(31)
            $0.height.equalTo(50)
        }
        loginCheckLabel.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview().offset(-30)
        }
        signupButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(10)
            $0.left.equalTo(loginCheckLabel.snp.right).offset(5)
            $0.centerY.equalTo(loginCheckLabel.snp.centerY)
        }
    }
    
    override func configureViewController() {
        self.view.backgroundColor = .white
    }
}


extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}

extension UIButton {
    func setUnderline() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: title.count)
        )
        setAttributedTitle(attributedString, for: .normal)
    }
}
