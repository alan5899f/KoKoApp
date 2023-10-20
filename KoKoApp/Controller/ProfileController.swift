//
//  ViewController.swift
//  KoKoApp
//
//  Created by 陳韋綸 on 2023/10/18.
//

import UIKit

class ProfileController: UIViewController {

    // MARK: ViewModel
    private let userViewModel = UserViewModel()
    private let friendsViewModel = FriendsViewModel()

    // MARK: View
    private let navigationBarView = NavigationBarView()
    private let profileView = ProfileView()
    private let inviteView = InviteView()
    private let selectedView = SelectedView()
    private let friendsView = FriendsView()
    private let noFriendsView = NoFriendsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor
        setNav()
        setView()
        friendsView.isHidden = false
        noFriendsView.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        friendsViewModel.bindingApi1()
        setUpUserResponse()
        setUpFriendsResponse()
        setHandle()
    }

    private func setNav() {

        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = .whiteColor
        barAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = barAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance

        navigationItem.leftBarButtonItem = navigationBarView.setLeftPadding(arrangedSubviews: [
            navigationBarView.atmBtn,
            navigationBarView.coinBtn
        ], padding: 30)

        navigationItem.rightBarButtonItem = navigationBarView.setQrCodeButton()
        
    }

    private func setView() {

        view.addSubview(profileView)
        view.addSubview(inviteView)
        view.addSubview(selectedView)
        view.addSubview(friendsView)
        view.addSubview(noFriendsView)

    }

    private func setLayout() {

        [
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            profileView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            profileView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
        ].forEach({
            $0.isActive = true
        })

        [
            inviteView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 15),
            inviteView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            inviteView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
        ].forEach({
            $0.isActive = true
        })

        [
            selectedView.topAnchor.constraint(equalTo: inviteView.bottomAnchor, constant: 25),
            selectedView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            selectedView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
        ].forEach({
            $0.isActive = true
        })

        // Info
        [
            friendsView.topAnchor.constraint(equalTo: selectedView.bottomAnchor, constant: 0),
            friendsView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            friendsView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            friendsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ].forEach({
            $0.isActive = true
        })

        [
            noFriendsView.topAnchor.constraint(equalTo: selectedView.bottomAnchor, constant: 0),
            noFriendsView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            noFriendsView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            noFriendsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ].forEach({
            $0.isActive = true
        })

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setLayout()
    }

}

// MARK: Response
extension ProfileController {

    private func setUpFriendsResponse() {

        friendsViewModel.friendsResponse = { [weak self] response in

            DispatchQueue.main.async {
                if response == [] {
                    self?.friendsView.isHidden = true
                    self?.noFriendsView.isHidden = false
                }
                else {
                    self?.friendsView.isHidden = false
                    self?.noFriendsView.isHidden = true
                }
            }

            self?.inviteView.setData(inviteData: response.filter({ $0.status == 0 }))
            self?.selectedView.setData(friendCount: response.filter({$0.status == 2}).count)
            self?.selectedView.setData(chatCount: 100)
            self?.friendsView.setData(response.filter({$0.status != 0}))

        }

        friendsViewModel.errorResponse = { error in
            print(error)
        }

    }

    private func setUpUserResponse() {

        userViewModel.bindingApi()

        userViewModel.userResponse = { [weak self] response in
            self?.profileView.setData(response.response?.first)
        }

        userViewModel.errorResponse = { error in
            print(error)
        }

    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}

// MARK: Handle
extension ProfileController {

    private func setHandle() {

        navigationBarView.atmHandle = { [weak self] in
            self?.setAlert()
        }

        friendsView.refreshCompletion = { [weak self] in
            self?.friendsViewModel.refreshBinding()
        }

    }

}

// MARK: Alert
extension ProfileController {

    private func setAlert() {

        let alert = UIAlertController(title: "選擇", message: "選擇需求", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "需求一 (無資料)", style: .default, handler: { [weak self] _ in
            self?.friendsViewModel.bindingApi1()
        }))
        alert.addAction(UIAlertAction(title: "需求二 (好友列表)", style: .default, handler: { [weak self] _ in
            self?.friendsViewModel.bindingApi2()
        }))
        alert.addAction(UIAlertAction(title: "需求三 (好友列表及邀請)", style: .default, handler: { [weak self] _ in
            self?.friendsViewModel.bindingApi3()
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        present(alert, animated: true)

    }

}
