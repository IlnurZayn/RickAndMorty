//
//  Extension + UIColor.swift
//  RickAndMorty
//
//  Created by Ilnur on 01.10.2023.
//

import UIKit

private enum Color: String {
    case acid
    case backgroundDarkGray
    case backgroundGray
    case indicatorGray
    case textColor
    case indicatorRed
    case indicatorGreen
}

extension UIColor {
    static let acidColor = UIColor(named: Color.acid.rawValue)
    static let textColor = UIColor(named: Color.textColor.rawValue)
    static let indicatorGrayColor = UIColor(named: Color.indicatorGray.rawValue)
    static let indicatorRedColor = UIColor(named: Color.indicatorRed.rawValue)
    static let indicatorGreenColor = UIColor(named: Color.indicatorGreen.rawValue)
    static let backgroundGrayColor = UIColor(named: Color.backgroundGray.rawValue)
    static let backgroundDarkGrayColor = UIColor(named: Color.backgroundDarkGray.rawValue)
}
