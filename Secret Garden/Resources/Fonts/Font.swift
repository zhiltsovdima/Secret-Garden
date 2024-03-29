//
//  Font.swift
//  Secret Garden
//
//  Created by Dima Zhiltsov on 11.05.2023.
//

import UIKit

enum Font {
    static let header = UIFont(name: "Montserrat-Bold", size: 24) ?? UIFont.boldSystemFont(ofSize: 24)
    static let subHeader = UIFont(name: "Montserrat-Bold", size: 16) ?? UIFont.boldSystemFont(ofSize: 16)

    static let general = UIFont(name: "Montserrat-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14)
    static let generalBold = UIFont(name: "Montserrat-SemiBold", size: 14) ?? UIFont.systemFont(ofSize: 14)
    static let generalLight = UIFont(name: "Montserrat-Light", size: 12) ?? UIFont.systemFont(ofSize: 12)
    static let thinText = UIFont(name: "Montserrat-Thin", size: 12) ?? UIFont.systemFont(ofSize: 12)

    static let buttonFont = UIFont(name: "Montserrat-SemiBold", size: 18) ?? UIFont.systemFont(ofSize: 18)
}
