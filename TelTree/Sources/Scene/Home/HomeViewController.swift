import UIKit
import SnapKit
import Then

class HomeViewController: BaseViewController {
    let tableView = UITableView().then {
        $0.register(
            HomeTableViewCell.self,
            forCellReuseIdentifier: HomeTableViewCell.identifier
        )
        $0.rowHeight = 134
    }

    override func configureViewController() {
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationItem.title = "TelTree"
    }

    override func addView() {
        self.view.addSubview(tableView)
    }

    override func setLayout() {
        tableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
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
        return cell
    }

}
