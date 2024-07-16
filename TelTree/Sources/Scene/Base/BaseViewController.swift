import UIKit
import RxSwift

class BaseViewController: UIViewController {
    let bound = UIScreen.main.bounds
    var disposeBag: DisposeBag = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureViewController()
        bind()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addView()
        setLayout()
    }

    func addView() {}
    func setLayout() {}
    func configureViewController() {}
    func bind() {}
}
