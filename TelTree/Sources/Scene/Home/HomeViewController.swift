import UIKit
import SnapKit
import Then

class HomeViewController: BaseViewController {
    
    var items: [String] = []
    var filteredItems: [String] = []
    var previousIndexPath: IndexPath?
    var selectedIndexPath: IndexPath?
    
    var searchBar = UISearchBar().then {
        //        $0.delegate = self
        $0.searchBarStyle = .minimal
        $0.showsCancelButton = true
        $0.searchTextField.backgroundColor = .clear
        $0.searchTextField.borderStyle = .none
    }
    
    let tableView = UITableView().then {
        $0.register(
            HomeTableViewCell.self,
            forCellReuseIdentifier: HomeTableViewCell.identifier
        )
        $0.rowHeight = 134
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func configureViewController() {
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationItem.title = "TelTree"
        self.reload()
    }
    
    override func addView() {
        self.view.addSubview(tableView)
        self.view.addSubview(searchBar)
    }
    
    override func setLayout() {
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(105)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(350)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20)
        }
    }
    func reload() {
        self.tableView.reloadData()
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterItems(with: searchText)
        self.reload()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        filterItems(with: "")
        self.reload()
    }
    
    func filterItems(with searchText: String) {
        if searchText.isEmpty {
            filteredItems = items
        } else {
            filteredItems = items.filter { $0.range(of: searchText, options: .caseInsensitive) != nil }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let donationDetailViewController = DonationDetailViewController()
        self.navigationController?.pushViewController(
            donationDetailViewController,
            animated: true
        )
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionTitles = getSectionTitles()
        if section < sectionTitles.count {
            return sectionTitles[section]
        }
        return nil
    }
    
    private func searchBarIsEmpty() -> Bool {
        return searchBar.text?.isEmpty ?? true
    }
    
    private func getSectionTitles() -> [String] {
        // 이름의 첫 글자로 이루어진 섹션 타이틀 배열을 반환합니다.
        let sectionTitles = items.map { name -> String in
            if let firstCharacter = name.first, let unicodeScalar = firstCharacter.unicodeScalars.first {
                let scalarValue = unicodeScalar.value
                if (0xAC00 <= scalarValue && scalarValue <= 0xD7A3) { // 첫 글자가 한글인 경우
                    let unicodeValue = scalarValue - 0xAC00
                    let choseongIndex = Int(unicodeValue / (21 * 28))
                    let choseong = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
                    let choseongCharacter = choseong[choseongIndex]
                    return choseongCharacter
                } else { // 첫 글자가 한글이 아닌 경우
                    return name.prefix(1).uppercased()
                }
            } else { // 이름이 비어있는 경우
                return ""
            }
        }
        
        let uniqueTitles = Array(Set(sectionTitles)).sorted()
        return uniqueTitles
    }
    
    private func getFilteredItemsInSection(_ section: Int) -> [String] {
        let sectionTitles = getSectionTitles()
        let sectionTitle = sectionTitles[section]
        
        let filteredItemsInSection: [String]
        if searchBarIsEmpty() {
            filteredItemsInSection = items.filter { item -> Bool in
                if let firstCharacter = item.first, let unicodeScalar = firstCharacter.unicodeScalars.first {
                    let scalarValue = unicodeScalar.value
                    if (0xAC00 <= scalarValue && scalarValue <= 0xD7A3) { // 첫 글자가 한글인 경우
                        let unicodeValue = scalarValue - 0xAC00
                        let choseongIndex = Int(unicodeValue / (21 * 28))
                        let choseong = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
                        let choseongCharacter = choseong[choseongIndex]
                        return "\(choseongCharacter)" == sectionTitle
                    } else { // 첫 글자가 한글이 아닌 경우
                        return item.prefix(1).uppercased() == sectionTitle
                    }
                } else { // 이름이 비어있는 경우
                    return sectionTitle.isEmpty
                }
            }
        } else {
            filteredItemsInSection = filteredItems.filter { item -> Bool in
                if let firstCharacter = item.first, let unicodeScalar = firstCharacter.unicodeScalars.first {
                    let scalarValue = unicodeScalar.value
                    if (0xAC00 <= scalarValue && scalarValue <= 0xD7A3) { // 첫 글자가 한글인 경우
                        let unicodeValue = scalarValue - 0xAC00
                        let choseongIndex = Int(unicodeValue / (21 * 28))
                        let choseong = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
                        let choseongCharacter = choseong[choseongIndex]
                        return "\(choseongCharacter)" == sectionTitle
                    } else { // 첫 글자가 한글이 아닌 경우
                        return item.prefix(1).uppercased() == sectionTitle
                    }
                } else { // 이름이 비어있는 경우
                    return sectionTitle.isEmpty
                }
            }
        }
        
        return filteredItemsInSection
    }
}
