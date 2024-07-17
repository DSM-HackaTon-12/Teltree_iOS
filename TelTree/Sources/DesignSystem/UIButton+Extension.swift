import UIKit

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
    
    func setTelTreeButton(setTitle: String) {
        self.setTitle(setTitle, for: .normal)
        self.backgroundColor = TelTreeAsset.green200.color
        self.layer.cornerRadius = 25
        self.tintColor = .white
    }
}


