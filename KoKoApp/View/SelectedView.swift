//
//  SelectedView.swift
//  KoKoApp
//
//  Created by 陳韋綸 on 2023/10/18.
//

import UIKit

enum SelectedType {
    case friend
    case chat
}

class SelectedView: UIView {

    private lazy var friendBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("好友", for: .normal)
        button.setTitleColor(.titleColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        button.addTarget(self, action: #selector(didTapFriend), for: .touchUpInside)
        return button
    }()

    private lazy var friendCount: UILabelDrawRect = {
        let label = UILabelDrawRect()
        label.padding = 4.5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .softPinkColor
        label.layer.cornerRadius = 9
        label.layer.masksToBounds = true
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        return label
    }()

    private lazy var chatBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("聊天", for: .normal)
        button.setTitleColor(.titleColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        button.addTarget(self, action: #selector(didTapChat), for: .touchUpInside)
        return button
    }()

    private lazy var chatCount: UILabelDrawRect = {
        let label = UILabelDrawRect()
        label.padding = 4.5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .softPinkColor
        label.layer.cornerRadius = 9
        label.layer.masksToBounds = true
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        return label
    }()

    private let selectedLine: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .hotPinkColor
        label.layer.cornerRadius = 2
        label.layer.masksToBounds = true
        return label
    }()

    private let hrLine: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .hrColor
        return label
    }()

    private var selectedType: SelectedType = .friend {
        didSet {
            switch selectedType {
            case .friend:
                friendHandle()
            case .chat:
                chatHandle()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .whiteColor
        translatesAutoresizingMaskIntoConstraints = false
        setView()
        setLayout()
        friendCount.isHidden = true
        chatCount.isHidden = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setData(friendCount count: Int) {

        DispatchQueue.main.async { [weak self] in
            self?.friendCount.isHidden = count == 0
            self?.friendCount.text = count.toString()
        }

    }

    public func setData(chatCount count: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.chatCount.isHidden = count == 0
            self?.chatCount.text = min(count, 99).toString() + (count > 99 ? "+" : "")
        }
    }

    private func setView() {

        addSubview(selectedLine)
        addSubview(friendBtn)
        addSubview(friendCount)
        addSubview(chatBtn)
        addSubview(chatCount)
        addSubview(hrLine)

    }

    private func setLayout() {

        [
            friendBtn.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            friendBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            friendBtn.heightAnchor.constraint(equalToConstant: 30)
        ].forEach({
            $0.isActive = true
        })

        [
            friendCount.bottomAnchor.constraint(equalTo: friendBtn.centerYAnchor, constant: 0),
            friendCount.leftAnchor.constraint(equalTo: friendBtn.rightAnchor, constant: 0),
            friendCount.heightAnchor.constraint(equalToConstant: 18),
        ].forEach({
            $0.isActive = true
        })

        [
            chatBtn.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            chatBtn.leftAnchor.constraint(equalTo: friendBtn.rightAnchor, constant: 36),
            chatBtn.heightAnchor.constraint(equalToConstant: 30)
        ].forEach({
            $0.isActive = true
        })

        [
            chatCount.bottomAnchor.constraint(equalTo: chatBtn.centerYAnchor, constant: 0),
            chatCount.leftAnchor.constraint(equalTo: chatBtn.rightAnchor, constant: 0),
            chatCount.heightAnchor.constraint(equalToConstant: 18),
        ].forEach({
            $0.isActive = true
        })

        [
            selectedLine.topAnchor.constraint(equalTo: friendBtn.bottomAnchor, constant: 0),
            selectedLine.centerXAnchor.constraint(equalTo: friendBtn.centerXAnchor, constant: 0),
            selectedLine.widthAnchor.constraint(equalToConstant: 24),
            selectedLine.heightAnchor.constraint(equalToConstant: 4)
        ].forEach({
            $0.isActive = true
        })

        [
            hrLine.topAnchor.constraint(equalTo: selectedLine.bottomAnchor, constant: 0),
            hrLine.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            hrLine.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            hrLine.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            hrLine.heightAnchor.constraint(equalToConstant: 1)
        ].forEach({
            $0.isActive = true
        })

    }

}

// MARK: Event
extension SelectedView {

    @objc private func didTapFriend() {
        selectedType = .friend
    }

    @objc private func didTapChat() {
        selectedType = .chat
    }

    private func friendHandle() {

        UIView.animate(withDuration: 0.5) { [self] in
            friendBtn.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
            chatBtn.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
            selectedLine.center.x = friendBtn.center.x
        }

    }

    private func chatHandle() {

        UIView.animate(withDuration: 0.5) { [self] in
            friendBtn.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
            chatBtn.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
            selectedLine.center.x = chatBtn.center.x
        }

    }

}
