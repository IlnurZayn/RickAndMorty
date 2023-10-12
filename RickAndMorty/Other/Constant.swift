//
//  Constant.swift
//  RickAndMorty
//
//  Created by Ilnur on 09.10.2023.
//

import UIKit

struct Constant {
    
    enum InsetOffset {
        static let s: CGFloat = 8.0
        static let m: CGFloat = 12.0
        static let l: CGFloat = 16.0
        static let xl: CGFloat = 20.0
        static let xxl: CGFloat = 24.0
    }
    
    enum FontSize {
        static let nameFontSize: CGFloat = 26.0
        static let descriptionFontSize: CGFloat = 17.0
    }
    
    enum BackgroundImage {
        static let image = UIImage(named: "Unowned")
    }
    
    enum CornerRadius {
        static let s: CGFloat = 10.0
    }
}
