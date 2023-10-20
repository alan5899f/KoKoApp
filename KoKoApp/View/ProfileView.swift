//
//  ProfileView.swift
//  KoKoApp
//
//  Created by 陳韋綸 on 2023/10/18.
//

import UIKit

class ProfileView: UIView {

    private let userName: UILabel = {
        let label = UILabel()
        label.text = "紫琳"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .titleColor
        label.font = .systemFont(ofSize: 17)
        return label
    }()

    private let userKokoId: UILabel = {
        let label = UILabel()
        label.text = "設定 KOKO ID"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .subTitleColor
        label.font = .systemFont(ofSize: 13, weight: .light)
        return label
    }()

    private let userKokoRightIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "RightArrowIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let userKokoCircle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .hotPinkColor
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        return label
    }()

    private let userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 32
        imageView.image = UIImage(named: "NoProfilePhotoIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .whiteColor
        translatesAutoresizingMaskIntoConstraints = false
        setView()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setView() {
        addSubview(userName)
        addSubview(userKokoId)
        addSubview(userKokoRightIcon)
        addSubview(userKokoCircle)
        addSubview(userImage)
    }

    private func setLayout() {

        [
            userName.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            userName.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            userName.heightAnchor.constraint(equalToConstant: 34)
        ].forEach({
            $0.isActive = true
        })

        [
            userKokoId.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 0),
            userKokoId.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            userKokoId.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            userKokoId.heightAnchor.constraint(equalToConstant: 30)
        ].forEach({
            $0.isActive = true
        })

        [
            userKokoRightIcon.centerYAnchor.constraint(equalTo: userKokoId.centerYAnchor, constant: 0),
            userKokoRightIcon.leftAnchor.constraint(equalTo: userKokoId.rightAnchor, constant: 0),
            userKokoRightIcon.widthAnchor.constraint(equalToConstant: 18),
            userKokoRightIcon.heightAnchor.constraint(equalToConstant: 18),
        ].forEach({
            $0.isActive = true
        })


        [
            userKokoCircle.centerYAnchor.constraint(equalTo: userKokoId.centerYAnchor, constant: 0),
            userKokoCircle.leftAnchor.constraint(equalTo: userKokoRightIcon.rightAnchor, constant: 15),
            userKokoCircle.widthAnchor.constraint(equalToConstant: 10),
            userKokoCircle.heightAnchor.constraint(equalToConstant: 10),
        ].forEach({
            $0.isActive = true
        })

        [
            userImage.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            userImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            userImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            userImage.widthAnchor.constraint(equalToConstant: 64)
        ].forEach({
            $0.isActive = true
        })

    }

    public func setData(_ data: UserModel?) {

        if let data = data {
            DispatchQueue.main.async { [weak self] in
                self?.userName.text = data.name

                if let kokoId = data.kokoid {
                    self?.userKokoCircle.isHidden = true
                    self?.userKokoId.text = "KOKO ID: " + kokoId
                }
                else {
                    self?.userKokoCircle.isHidden = false
                    self?.userKokoId.text = "設定 KOKO ID"
                }

            }
        }

    }

}
