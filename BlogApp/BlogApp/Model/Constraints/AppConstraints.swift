//
//  AppConstraints.swift
//  AsthaBlogSample
//
//  Created by Astha on 23/06/20.
//  Copyright © 2020 Astha Sahay. All rights reserved.
//

import UIKit

class AppConstraints: NSObject {
    
    class func formatPoints(_ num: Double, place: Int) ->String{
        var thousands = num / 1000
        var millions = num / 1000000
        if num >= 1000 && num < 1000000{
            if(floor(thousands) == thousands){
                return("\(Int(thousands))k")
            }
            return("\(thousands.roundToPlaces(place))k")
        }
        if num > 1000000{
            if(floor(millions) == millions){
                return("\(Int(thousands))k")
            }
            return ("\(millions.roundToPlaces(place))M")
        }
        else{
            if(floor(num) == num){
                return ("\(Int(num))")
            }
            return ("\(num)")
        }
    }
    
    class func timeAgoSinceDate(_ date:Date, numericDates:Bool) -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        let now = currentDate
        let earliest = (now as NSDate).earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute , NSCalendar.Unit.hour , NSCalendar.Unit.day , NSCalendar.Unit.weekOfYear , NSCalendar.Unit.month , NSCalendar.Unit.year , NSCalendar.Unit.second], from: earliest, to: latest, options: NSCalendar.Options())

        if (components.year! >= 2) {
            return "\(components.year!) years"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 year"
            } else {
                return "Last year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) months"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 month"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) days"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 day"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hours"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 hour"
            } else {
                return "An hour"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 minute"
            } else {
                return "A minute"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!) seconds"
        } else {
            return "Just now"
        }

    }
}
