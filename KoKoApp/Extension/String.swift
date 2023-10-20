//
//  String.swift
//  KoKoApp
//
//  Created by 陳韋綸 on 2023/10/19.
//

import Foundation

extension String {

    func toDate1970Double() -> Double {

        let dateFormatter = DateFormatter()

        if self.contains("/") {
            dateFormatter.dateFormat = "yyyy/MM/dd"
        }
        else {
            dateFormatter.dateFormat = "yyyyMMdd"
        }

        return dateFormatter.date(from: self)?.timeIntervalSince1970 ?? 0.0

    }

}
