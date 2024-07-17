import UIKit

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }

    func setTelTreeTextField(placeholder: String, radius: CGFloat = 25) {
        self.placeholder = placeholder
        
        self.backgroundColor = TelTreeAsset.gray100.color
        self.layer.borderWidth = 1
        self.layer.borderColor = TelTreeAsset.gray200.color.cgColor
        self.layer.cornerRadius = radius
        self.addLeftPadding()
    }
}
