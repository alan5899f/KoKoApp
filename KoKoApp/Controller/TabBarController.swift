//
//  TabBarController.swift
//  KoKoApp
//
//  Created by 陳韋綸 on 2023/10/20.
//

import UIKit

class TabBarController: UITabBarController {

    let middleButton = UIButton()
    let middleButtonHeight: CGFloat = 100
    let barImgWidth: CGFloat = 50

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMiddleButton()

        tabBar.backgroundColor = .white

        let tabbar1Img = resizeImage(image: UIImage(named: "TabBar1")!, targetSize: CGSize(width: barImgWidth, height: barImgWidth))
        let tabbar2Img = resizeImage(image: UIImage(named: "TabBar2")!, targetSize: CGSize(width: barImgWidth, height: barImgWidth))
        let tabbar4Img = resizeImage(image: UIImage(named: "TabBar4")!, targetSize: CGSize(width: barImgWidth, height: barImgWidth))
        let tabbar5Img = resizeImage(image: UIImage(named: "TabBar5")!, targetSize: CGSize(width: barImgWidth, height: barImgWidth))

        let vc1 = ProfileController()
        let vc2 = ProfileController()
        let vc3 = ProfileController()
        let vc4 = ProfileController()
        let vc5 = ProfileController()

        vc1.tabBarItem = UITabBarItem(title: "", image: tabbar1Img?.withRenderingMode(.alwaysOriginal), tag: 1)
        vc2.tabBarItem = UITabBarItem(title: "", image: tabbar2Img?.withRenderingMode(.alwaysOriginal), tag: 2)
        vc4.tabBarItem = UITabBarItem(title: "", image: tabbar4Img?.withRenderingMode(.alwaysOriginal), tag: 4)
        vc5.tabBarItem = UITabBarItem(title: "", image: tabbar5Img?.withRenderingMode(.alwaysOriginal), tag: 5)

        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        let nav5 = UINavigationController(rootViewController: vc5)

        setViewControllers([nav1,nav2,nav3,nav4,nav5], animated: true)

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.bringSubviewToFront(middleButton)
    }

    private func setupMiddleButton() {
        middleButton.setImage(UIImage(named: "TabBar3"), for: .normal)

        middleButton.translatesAutoresizingMaskIntoConstraints = false
        tabBar.addSubview(middleButton)

        let heightDifference = (tabBar.frame.height / 2) - (middleButtonHeight / 2)

        [
            middleButton.widthAnchor.constraint(equalToConstant: middleButtonHeight),
            middleButton.heightAnchor.constraint(equalToConstant: middleButtonHeight),
            middleButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor, constant: 0),
            middleButton.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: heightDifference),
        ].forEach({
            $0.isActive = true
        })
    }

}
