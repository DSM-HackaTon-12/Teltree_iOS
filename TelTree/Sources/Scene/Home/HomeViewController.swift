import UIKit
import SnapKit
import Then
import Moya

class HomeViewController: BaseViewController {
    
    private let manager: Session = Session(configuration: URLSessionConfiguration.default, serverTrustManager: CustomServerTrustManager())
    private lazy var provider = MoyaProvider<PostAPI>(session: manager, plugins: [MoyaLoggingPlugin()])
    
    let tableView = UITableView().then {
        $0.register(
            HomeTableViewCell.self,
            forCellReuseIdentifier: HomeTableViewCell.identifier
        )
        $0.rowHeight = 134
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        getHomeList()
    }
    
    override func configureViewController() {
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationItem.title = "TelTree"
    }
    
    override func addView() {
        self.view.addSubview(tableView)
    }
    
    private func getHomeList() {
        provider.request(.mainpage){ result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print("실패")
            }
        }
    }
    
    override func setLayout() {
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20)
        }
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: HomeTableViewCell.identifier,
            for: indexPath
        )
//        let model = data[indexPath.row]
//        cell.setup(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let donationDetailViewController = DonationDetailViewController()
        self.navigationController?.pushViewController(
            donationDetailViewController,
            animated: true
        )
    }
}
