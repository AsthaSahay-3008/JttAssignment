//
//  Double+Round.swift
//  AsthaBlogSample
//
//  Created by Astha on 23/06/20.
//  Copyright © 2020 Astha Sahay. All rights reserved.
//

import UIKit

extension Double {
    /// Rounds the double to decimal places value
    mutating func roundToPlaces(_ places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
