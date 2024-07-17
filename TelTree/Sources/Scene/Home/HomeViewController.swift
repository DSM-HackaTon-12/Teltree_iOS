import UIKit
import SnapKit
import Then
import Moya

class HomeViewController: BaseViewController {
    var listData: [MainpageEntity] = []
    var data: [Int] = [3,4,24,43,24]

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
        provider.request(.mainpage(token: Token.accessToken ?? "")){ result in
            switch result {
            case .success(let response):
                do {
                    let responseData = try JSONDecoder().decode(MainpageResponse.self, from: response.data)
                    self.listData = responseData.posts.map {
                        $0.toEntity()
                    }
                    self.tableView.reloadData()
                } catch let error {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
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
        listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: HomeTableViewCell.identifier,
            for: indexPath
        ) as? HomeTableViewCell
        let data = listData[indexPath.row]
        cell?.setup(
            image: data.imageURL,
            title: data.title,
            subTitle: data.address,
            data: "\(data.startDate) ~ \(data.endDate)",
            postId: data.postID
        )
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? HomeTableViewCell

        let donationDetailViewController = DonationDetailViewController()
        donationDetailViewController.postId = cell?.postId ?? 0
        self.navigationController?.pushViewController(
            donationDetailViewController,
            animated: true
        )
    }
}
