import UIKit
import SnapKit
import Then

class ReviewViewController: BaseViewController {
    
    
    let tableView = UITableView().then {
        $0.register(
            ReviewTableCell.self,
            forCellReuseIdentifier: ReviewTableCell.identifier
        )
        $0.rowHeight = 196
    }
    
    override func configureViewController() {
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "리뷰"
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    override func addView() {
        view.addSubview(tableView)
//        view.addSubview(reviewTitle)
    }
    
    override func setLayout() {
        tableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20)
        }
//        reviewTitle.snp.makeConstraints {
//            $0.top.equalToSuperview().inset(118)
//            $0.left.equalToSuperview().inset(21)
//        }
    }
}

extension ReviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ReviewTableCell.identifier,
            for: indexPath
        )
        return cell
        
    }
}
