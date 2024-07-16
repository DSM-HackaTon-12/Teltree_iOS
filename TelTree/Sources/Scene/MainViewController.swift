import UIKit
import SnapKit
import Then

class MainViewController: BaseViewController {
    
    let label = UILabel().then {
        $0.text = "하원"
        $0.textColor = TelTreeAsset.main.color
    }
    override func addView() {
        self.view.addSubview(label)
    }
    override func setLayout() {
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    override func configureViewController() {
        self.view.backgroundColor = .red
    }
}
