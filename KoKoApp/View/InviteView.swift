//
//  InviteView.swift
//  KoKoApp
//
//  Created by 陳韋綸 on 2023/10/18.
//

import UIKit

enum InviteType {
    case close
    case presnt
    case none
}

class InviteView: UIView {

    private var inviteData: [FriendModel] = [] {
        didSet {

            DispatchQueue.main.async { [weak self] in
                self?.inviteSecondBackground.isHidden = self?.inviteData.count ?? 0 < 2
                self?.inviteTableView.reloadData()
            }

        }
    }

    var inviteTableViewHeight: NSLayoutConstraint?

    private var inviteType: InviteType = .none {
        didSet {

            DispatchQueue.main.async { [self] in
                switch inviteType {
                case .close:

                    inviteTableViewHeight?.constant = 80
                    inviteSecondBackground.isHidden = false

                case .presnt:

                    inviteTableViewHeight?.constant = CGFloat(inviteData.count * 80)
                    inviteSecondBackground.isHidden = true

                case .none:

                    inviteTableViewHeight?.constant = 0
                    inviteSecondBackground.isHidden = true

                }
            }

        }
    }

    private lazy var inviteTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(InviteCell.self, forCellReuseIdentifier: InviteCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .whiteColor
        return tableView
    }()

    private let inviteSecondBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.layer.shadowOpacity = 1.5
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowColor = UIColor.black10Color.cgColor
        view.isHidden = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setView()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setData(inviteData data: [FriendModel]) {

        if data == [] {
            inviteType = .none
        }
        else {
            inviteType = .close
        }

        inviteData = data
    }

    private func setView() {

        addSubview(inviteSecondBackground)
        addSubview(inviteTableView)

    }

    private func setLayout() {

        [
            inviteTableView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            inviteTableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            inviteTableView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            inviteTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ].forEach({
            $0.isActive = true
        })

        inviteTableViewHeight = inviteTableView.heightAnchor.constraint(equalToConstant: 0)
        inviteTableViewHeight?.isActive = true

        [
            inviteSecondBackground.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            inviteSecondBackground.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
            inviteSecondBackground.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
            inviteSecondBackground.heightAnchor.constraint(equalToConstant: 80)
        ].forEach({
            $0.isActive = true
        })

    }

}

// MARK: Delegate
extension InviteView: UITableViewDelegate, UITableViewDataSource, InviteDelegate {

    func didTapContent() {
        if inviteType == .close {
            inviteType = .presnt
        }
        else if inviteType == .presnt {
            inviteType = .close
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InviteCell.identifier, for: indexPath) as? InviteCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.selectionStyle = .none
        cell.setData(data: inviteData[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inviteData.count
    }

}
