//
//  SearchBarView.swift
//  KoKoApp
//
//  Created by 陳韋綸 on 2023/10/18.
//

import UIKit

class SearchTextField: UITextField {

    init() {
        super.init(frame: .zero)

        let imageView = UIImageView(image: UIImage(named: "MagnifierIcon"))
        imageView.contentMode = .scaleAspectFit

        translatesAutoresizingMaskIntoConstraints = false
        leftViewMode = .always
        leftView = imageView
        placeholder = "想轉一筆給誰呢？"
        backgroundColor = .steel12Color
        layer.cornerRadius = 10
        layer.masksToBounds = true

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 10, y: 11, width: 24, height: 14)
    }

}
