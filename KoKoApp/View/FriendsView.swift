//
//  SelectedView.swift
//  KoKoApp
//
//  Created by 陳韋綸 on 2023/10/18.
//

import UIKit

class FriendsView: UIView {

    public var refreshCompletion: () -> () = {}

    private let searchField = SearchTextField()

    private var friendsData: [FriendModel] = []

    private var searchData: [FriendModel] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.friendsTableView.reloadData()
            }
        }
    }

    private let searchRightIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "SearchAddIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var refresh: UIRefreshControl = {
        let refresh = UIRefreshControl(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        refresh.addTarget(self, action: #selector(didTapRefresh), for: .valueChanged)
        return refresh
    }()


    private lazy var friendsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FriendsCell.self, forCellReuseIdentifier: FriendsCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.refreshControl = refresh
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        searchField.delegate = self
        setView()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setData(_ data: [FriendModel]) {

        searchData = data
        friendsData = data

    }

    private func setView() {

        addSubview(searchField)
        addSubview(searchRightIcon)
        addSubview(friendsTableView)

    }

    private func setLayout() {

        [
            searchField.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            searchField.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            searchField.rightAnchor.constraint(equalTo: searchRightIcon.leftAnchor, constant: -15),
            searchField.heightAnchor.constraint(equalToConstant: 36),
        ].forEach({
            $0.isActive = true
        })

        [
            searchRightIcon.centerYAnchor.constraint(equalTo: searchField.centerYAnchor, constant: 0),
            searchRightIcon.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            searchRightIcon.widthAnchor.constraint(equalToConstant: 24),
            searchRightIcon.heightAnchor.constraint(equalToConstant: 24),
        ].forEach({
            $0.isActive = true
        })

        [
            friendsTableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 10),
            friendsTableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            friendsTableView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            friendsTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ].forEach({
            $0.isActive = true
        })

    }

}

// MARK: Event
extension FriendsView {

    @objc private func didTapRefresh() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.refreshCompletion()
            self?.refresh.endRefreshing()
        }

    }

}

// MARK: UITextFieldDelegate
extension FriendsView: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updateText = text.replacingCharacters(in: textRange, with: string)

            if updateText.isEmpty {

                searchData = friendsData

            }
            else {

                searchData = friendsData.filter({$0.name!.contains(updateText)})

            }

        }

        return true
    }

}

// MARK: UITableViewDelegate
extension FriendsView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendsCell.identifier, for: indexPath) as? FriendsCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.setData(searchData[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData.count
    }

}
