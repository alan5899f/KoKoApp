//
//  NoFriendView.swift
//  KoKoApp
//
//  Created by 陳韋綸 on 2023/10/18.
//

import UIKit

class NoFriendsView: UIView {

    private let noFriendImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "NoFriendsIcon")
        return imageView
    }()

    private let noFriendTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .titleColor
        label.textAlignment = .center
        label.text = "就從加好友開始吧 : )"
        label.font = .systemFont(ofSize: 21, weight: .medium)
        return label
    }()

    private let noFriendSubTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .subTitleColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "與好友們一起用 KOKO 聊起來!\n還能互相收付款"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    private let addFriendBtn: UIButton = {

        var configuration = UIButton.Configuration.filled()
        configuration.imagePlacement = .trailing
        configuration.image = UIImage(named: "AddFriendsIcon")
        configuration.contentInsets = .init(top: 0, leading: 60, bottom: 0, trailing: 0)
        configuration.imagePadding = 40
        configuration.titleAlignment = .center
        configuration.baseBackgroundColor = .clear

        var attText = AttributedString.init("加好友")
        attText.font = .systemFont(ofSize: 16, weight: .medium)
        configuration.attributedTitle = attText

        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear

        return button
    }()

    private let describeText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .subTitleColor
        label.textAlignment = .center
        label.text = "幫助好友更快找到你？"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    private let kokoIdBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 14)
        let attributeString = NSMutableAttributedString(string: "設定 KOKO ID", attributes: [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.hotPinkColor,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        button.setAttributedTitle(attributeString, for: .normal)
        return button
    }()

    private lazy var stackview: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [describeText, kokoIdBtn])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 0
        stackview.axis = .horizontal
        return stackview
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        setView()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setView() {
        addSubview(scrollView)
        scrollView.addSubview(noFriendImage)
        scrollView.addSubview(noFriendTitle)
        scrollView.addSubview(noFriendSubTitle)
        scrollView.addSubview(addFriendBtn)
        scrollView.addSubview(stackview)

    }

    private func setLayout() {

        [
            scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ].forEach({
            $0.isActive = true
        })

        [
            noFriendImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            noFriendImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0),
            noFriendImage.widthAnchor.constraint(equalToConstant: 245),
            noFriendImage.heightAnchor.constraint(equalToConstant: 172),
        ].forEach({
            $0.isActive = true
        })

        [
            noFriendTitle.topAnchor.constraint(equalTo: noFriendImage.bottomAnchor, constant: 41),
            noFriendTitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0),
        ].forEach({
            $0.isActive = true
        })

        [
            noFriendSubTitle.topAnchor.constraint(equalTo: noFriendTitle.bottomAnchor, constant: 8),
            noFriendSubTitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0),
        ].forEach({
            $0.isActive = true
        })

        [
            addFriendBtn.topAnchor.constraint(equalTo: noFriendSubTitle.bottomAnchor, constant: 25),
            addFriendBtn.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0),
            addFriendBtn.widthAnchor.constraint(equalToConstant: 192),
            addFriendBtn.heightAnchor.constraint(equalToConstant: 40),
        ].forEach({
            $0.isActive = true
        })

        [
            stackview.topAnchor.constraint(equalTo: addFriendBtn.bottomAnchor, constant: 37),
            stackview.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0),
        ].forEach({
            $0.isActive = true
        })

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        addFriendBtn.layoutIfNeeded()
        addFriendBtn.setupGradient(colors: [.frogColor, .boogerColor])
        
        scrollView.subviews.forEach({$0.layoutIfNeeded()})
        scrollView.contentSize = CGSize(
            width: Width,
            height: scrollView.subviews.compactMap({$0.height}).reduce(0, +) + 141
        )
        scrollView.layoutIfNeeded()
    }

}
