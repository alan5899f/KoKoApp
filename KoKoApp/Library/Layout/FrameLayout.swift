//
//  FrameLayout.swift
//  KoKoApp
//
//  Created by 陳韋綸 on 2023/10/19.
//

import UIKit

extension UIView {
    
    public var width: CGFloat {
        return frame.size.width
    }
    
    public var height: CGFloat {
        return frame.size.height
    }
    
    public var top: CGFloat {
        return frame.origin.y
    }
    
    public var left: CGFloat {
        return frame.origin.x
    }
    
    public var bottom: CGFloat {
        return frame.origin.y + frame.size.height
    }
    
    public var right: CGFloat {
        return frame.origin.x + frame.size.width
    }
}

