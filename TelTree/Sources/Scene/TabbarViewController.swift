import UIKit
import Then
class TabbarViewController: UITabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpTabBarLayout()
        setUpTabBarItem()

        if Token.accessToken == nil {
            let loginViewController = LoginViewController()
            loginViewController.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.present(loginViewController, animated: true)
            }
        }
    }

    override func viewDidLoad() {
//        Token.accessToken = nil
    }

    func setUpTabBarLayout() {
        let tabBar: UITabBar = self.tabBar
        tabBar.unselectedItemTintColor = TelTreeAsset.gray300.color
        tabBar.tintColor = TelTreeAsset.green200.color
        tabBar.backgroundColor = .white
        tabBar.layer.borderColor = TelTreeAsset.gray200.color.cgColor
        tabBar.layer.borderWidth = 1
        self.hidesBottomBarWhenPushed = true
    }

    func setUpTabBarItem() {
        let homeViewController = BaseNavigationController(
            rootViewController:  HomeViewController()
        )
        homeViewController.tabBarItem = UITabBarItem(
            title: "HOME",
            image: TelTreeAsset.home.image,
            selectedImage: TelTreeAsset.home.image
        )
        let mapViewController = BaseNavigationController(
            rootViewController: MapViewController()
        )
        mapViewController.tabBarItem = UITabBarItem(
            title: "MAP",
            image: TelTreeAsset.map.image,
            selectedImage: TelTreeAsset.map.image
        )
        let writeViewController = UIViewController().then {
            $0.view.backgroundColor = .white
        }
        writeViewController.tabBarItem = UITabBarItem(
            title: "ADD",
            image: TelTreeAsset.add.image,
            selectedImage: TelTreeAsset.add.image
        )
        let reviewViewController = BaseNavigationController(
            rootViewController: ReviewViewController()
        )
        reviewViewController.tabBarItem = UITabBarItem(
            title: "REVIEW",
            image: TelTreeAsset.star.image,
            selectedImage: TelTreeAsset.star.image
        )
        let myViewController = BaseNavigationController(
            rootViewController: MyViewController()
        )
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
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == "ADD" {
            let writeViewContoller = WriteViewController()
            writeViewContoller.modalPresentationStyle = .overFullScreen
            self.present(writeViewContoller, animated: true) {
                self.selectedIndex = 0
            }
        }
    }
}

