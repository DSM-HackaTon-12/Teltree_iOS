import UIKit
import Then
class TabbarViewController: UITabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpTabBarLayout()
        setUpTabBarItem()
    }

    func setUpTabBarLayout() {
        let tabBar: UITabBar = self.tabBar
        tabBar.unselectedItemTintColor = .gray
        tabBar.tintColor = TelTreeAsset.main.color
        tabBar.backgroundColor = .white
        tabBar.layer.borderColor = UIColor.black.cgColor
        tabBar.layer.borderWidth = 1
        self.hidesBottomBarWhenPushed = true
    }

    func setUpTabBarItem() {
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(
            title: "HOME",
            image: TelTreeAsset.home.image,
            selectedImage: TelTreeAsset.home.image
        )
        let mapViewController = MapViewController()
        mapViewController.tabBarItem = UITabBarItem(
            title: "MAP",
            image: TelTreeAsset.map.image,
            selectedImage: TelTreeAsset.map.image
        )
        let writeViewController = WriteViewController()
        let reviewViewController = ReviewViewController()
        reviewViewController.tabBarItem = UITabBarItem(
            title: "REVIEW",
            image: TelTreeAsset.star.image,
            selectedImage: TelTreeAsset.star.image
        )
        let myViewController = MyViewController()
        myViewController.tabBarItem = UITabBarItem(
            title: "MY",
            image: TelTreeAsset.person.image,
            selectedImage: TelTreeAsset.person.image
        )
        viewControllers = [
            homeViewController,
            mapViewController,
            writeViewController,
            reviewViewController,
            myViewController
        ]
        setupMiddleButton()
    }

    func setupMiddleButton() {
        let menuButton = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40)).then {
            $0.image = TelTreeAsset.add.image
            $0.isUserInteractionEnabled = false
        }
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - (self.tabBar.frame.height / 2) - 10
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        
        view.addSubview(menuButton)
        
        view.layoutIfNeeded()
    }
}

