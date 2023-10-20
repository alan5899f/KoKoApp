//
//  NavigationBar.swift
//  Interviews
//
//  Created by 陳韋綸 on 2023/10/11.
//

import Foundation
import UIKit

class NavigationBarView {

    var atmHandle: () -> () = { }
    var coinHandle: () -> () = { }
    var qrCodeHandle: () -> () = { }

    public lazy var atmBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ATMIcon"), for: .normal)
        button.addTarget(self, action: #selector(didTapAtm), for: .touchUpInside)
        return button
    }()

    public lazy var coinBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "CoinIcon"), for: .normal)
        button.addTarget(self, action: #selector(didTapCoin), for: .touchUpInside)
        return button
    }()

    public lazy var qrCodeBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "QrCodeIcon"), for: .normal)
        button.addTarget(self, action: #selector(didTapQrCode), for: .touchUpInside)
        return button
    }()

    func setAtmButton() -> UIBarButtonItem {
        return UIBarButtonItem(customView: atmBtn)
    }

    func setCoinButton() -> UIBarButtonItem {
        return UIBarButtonItem(customView: coinBtn)
    }

    func setQrCodeButton() -> UIBarButtonItem {
        return UIBarButtonItem(customView: qrCodeBtn)
    }

    func setLeftPadding(arrangedSubviews: [UIView], padding: CGFloat) -> UIBarButtonItem {

        let stackview = UIStackView.init(arrangedSubviews: arrangedSubviews)
        stackview.distribution = .equalSpacing
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.spacing = padding

        return UIBarButtonItem(customView: stackview)
    }

}

// MARK: Event
extension NavigationBarView {

    @objc private func didTapAtm() {
        atmHandle()
    }

    @objc private func didTapCoin() {
        coinHandle()
    }

    @objc private func didTapQrCode() {
        qrCodeHandle()
    }

}
