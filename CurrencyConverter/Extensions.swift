//
//  Extensions.swift
//  CurrencyConverter
//
//  Created by Mohamed Elzohirey on 01/08/2021.
//

import UIKit

extension String{
    func flag() -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in self.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
}

extension UIColor{
    public struct AppColors{
        static let BlackColor:UIColor = UIColor(named: "black") ?? .black
        static let DarkBlueColor:UIColor = UIColor(named: "darkBlue") ?? .blue
        static let RedColor:UIColor = UIColor(named: "red") ?? .red
        static let BlueColor:UIColor = UIColor(named: "blue") ?? .blue
    }
}
