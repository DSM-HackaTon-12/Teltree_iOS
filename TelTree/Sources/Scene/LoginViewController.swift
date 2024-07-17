import UIKit
import SnapKit
import Then
import Moya

class LoginViewController: BaseViewController {
    private let provider = MoyaProvider<UserAPI>()
    
    let loginLabel = UILabel().then {
        $0.text = "로그인"
        $0.font = .systemFont(ofSize: 30)
    }
    
    let emailLabel = UILabel().then {
        $0.text = "이메일"
    }
    
    let emailField = UITextField().then {
        $0.setTelTreeTextField(placeholder: "이메일을 입력해 주세요")
    }
    
    let pwdLabel = UILabel().then {
        $0.text = "비밀번호"
    }
    
    let pwdField = UITextField().then {
        $0.setTelTreeTextField(placeholder: "비밀번호를 입력해 주세요")
        $0.isSecureTextEntry = true
    }
    
    let loginButton = UIButton(type: .system).then {
        $0.setTelTreeButton(setTitle: "로그인")
        $0.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
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
    
    @objc func loginButtonTapped() {
        provider.request(.login(email: emailField.text!, password: pwdField.text!)) { result in
            switch result {
            case .success:
                print("성공")
            case .failure:
                print("Asdf")
            }
        }
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



