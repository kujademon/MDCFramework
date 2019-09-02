//
//  NSDateExtension.swift
//
//  Created by Pawarit Phrompuak on 7/8/16.
//  Copyright © 2016 - 2026. All rights reserved.
//

import UIKit

extension Date {
    
    var second: Double {
        get {
            
            return 1.0
        }
    }
    
    var minute: Double {
        get {
            
            return second * 60
        }
    }
    
    var hour: Double {
        get {
            
            return minute * 60
        }
    }
    
    var day: Double {
        get {
            
            return hour * 24
        }
    }
    
    var week: Double {
        get {
            
            return day * 7
        }
    }
    
    var month: Double {
        get {
            
            return day * 31
        }
    }
    
    var year: Double {
        get {
            
            return day * 365.25
        }
    }
    
    
    func readableFormat(_ date: Date) -> String {
        
        let now = Date()
        
        let gregorianCalendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = gregorianCalendar
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        dateFormatter.timeZone = TimeZone.current
        
        let dateString = dateFormatter.string(from: now)
        
        let gregorianDate = dateFormatter.date(from:dateString)
        
        let secondsSince = -(date.timeIntervalSince(gregorianDate!))
        
        // < 1 minute = "Just now"
        if secondsSince < minute {
            
            return NSLocalizedString("Just_now", comment: "")
            
            // < 1 hour = "x mins"
        } else if secondsSince < self.hour {
            
            return minutesFormat(secondsSince)
            
            // Today = "x hrs"
        } else if isToday(gregorianDate!) {
            
            return todayFormat(secondsSince)
            
            // Yesterday = "Yesterday at 9:41 AM"
        } else if isYesterday(gregorianDate!) {
            
            return yesterdayFormat()
            
            // Last 7 days = "Friday at 9:41 AM"
        }
        else if isLastWeek(secondsSince) {
            
            return lastWeekFormat()
            
            // Others = "1 December at 9:41 AM"
        }
        
        return othersFormat()
    }
    
    func isToday(_ now: Date) -> Bool {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        dateFormatter.timeZone = TimeZone.current
        
        let date = dateFormatter.string(from: now)
        let compareDate = dateFormatter.string(from: self)
        
        return date.compare(compareDate) == .orderedSame
    }
    
    func isYesterday(_ now: Date) -> Bool {
        
        let calendar = Calendar.current
        
        var offset = DateComponents()
        offset.day = -1
        
        let yesterdayDate = calendar.date(byAdding: offset, to: now, wrappingComponents: true)
        
        return isToday(yesterdayDate!)
    }
    
    func isLastWeek(_ secs: TimeInterval) -> Bool {
        
        let calendar = Calendar.current
       
        let components = calendar.dateComponents([.hour, .minute, .second], from: Date())
        
        let hrsPastMidnight = Double(components.hour!)
        let minsPastMidnight = Double(components.minute!)
        let secsPastMidnight = Double(components.second!)
        
        let additionalSecs = (hrsPastMidnight * 60 * 60) + (minsPastMidnight * 60) + secsPastMidnight
        
        return secs < (week + additionalSecs)
    }
    
    func minutesFormat(_ secs: TimeInterval) -> String {
        
        let mins = Int(secs / minute)
        
        if mins == 1 {
            
            return "1 \(NSLocalizedString("min", comment: ""))"
            
        } else {
            
            return "\(mins) \(NSLocalizedString("mins", comment: ""))"
        }
    }
    
    func todayFormat(_ secs: TimeInterval) -> String {
        
        let hrs = Int(secs / hour)
        
        if hrs == 1 {
            
            return "1 \(NSLocalizedString("hr", comment: ""))"
            
        } else {
            
            return "\(hrs) \(NSLocalizedString("hrs", comment: ""))"
        }
    }
    
    func yesterdayFormat() -> String {
        
        let lang = "th" //NSLocale.currentLocale().objectForKey(NSLocaleLanguageCode) as! String
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        
        if lang.caseInsensitiveCompare("th") == .orderedSame {
            
            dateFormatter.dateFormat = "HH:mm 'น.'"
        
        } else {
            
            dateFormatter.dateFormat = "h:mm a"
        }
        
        dateFormatter.locale = Locale(identifier: "th_TH")
        
        let localDate = dateFormatter.string(from: self)
        
        return "\(NSLocalizedString("Yesterday_at", comment: "")) \(localDate)"
    }
    
    func lastWeekFormat() -> String {
        
        let lang = "th" //NSLocale.currentLocale().objectForKey(NSLocaleLanguageCode) as! String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.timeZone = TimeZone.current
        
        let localDay = dateFormatter.string(from: self)
        let todayDay = dateFormatter.string(from: Date())
        
        if todayDay.compare(localDay) == .orderedSame {
            
            if lang.caseInsensitiveCompare("th") == .orderedSame {
                
                dateFormatter.dateFormat = "d MMMM '\(NSLocalizedString("at", comment: ""))' HH:mm 'น.'"
                
            } else {
                
                dateFormatter.dateFormat = "'Last' EEEE '\(NSLocalizedString("at", comment: ""))' h:mm a"
            }
            
        } else {
            
            if lang.caseInsensitiveCompare("th") == .orderedSame {
                
                dateFormatter.dateFormat = "EEEE '\(NSLocalizedString("at", comment: ""))' HH:mm 'น.'"
            
            } else {
                
                dateFormatter.dateFormat = "EEEE '\(NSLocalizedString("at", comment: ""))' h:mm a"
            }
        }
        
        dateFormatter.locale = Locale(identifier: "th_TH")
        
        let localDate = dateFormatter.string(from: self)
        
        return localDate
    }
    
    func othersFormat() -> String {
        
        let lang = "th" //NSLocale.currentLocale().objectForKey(NSLocaleLanguageCode) as! String
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        
        if lang.caseInsensitiveCompare("th") == .orderedSame {
            
            dateFormatter.dateFormat = "d MMMM '\(NSLocalizedString("at", comment: ""))' HH:mm 'น.'"
            
        } else {
            
            dateFormatter.dateFormat = "d MMMM '\(NSLocalizedString("at", comment: ""))' h:mm a"
        }
        
        dateFormatter.locale = Locale(identifier: "th_TH")
        
        let localDate = dateFormatter.string(from: self)
        
        return localDate
    }
    
    func yearsFrom(_ date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year!
    }
    func monthsFrom(_ date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month!
    }
    func weeksFrom(_ date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear!
    }
    func daysFrom(_ date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day!
    }
    func hoursFrom(_ date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour!
    }
    func minutesFrom(_ date: Date) -> Int{
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute!
    }
    func secondsFrom(_ date: Date) -> Int{
        return Calendar.current.dateComponents([.second], from: date, to: self).second!
    }
    func offsetFrom(date: Date) -> String {
        if yearsFrom(date)   > 0 { return "\(yearsFrom(date))y"   }
        if monthsFrom(date)  > 0 { return "\(monthsFrom(date))M"  }
        if weeksFrom(date)   > 0 { return "\(weeksFrom(date))w"   }
        if daysFrom(date)    > 0 { return "\(daysFrom(date))d"    }
        if hoursFrom(date)   > 0 { return "\(hoursFrom(date))h"   }
        if minutesFrom(date) > 0 { return "\(minutesFrom(date))m" }
        if secondsFrom(date) > 0 { return "\(secondsFrom(date))s" }
        return ""
    }
    
    func offsetFromFull(_ date:Date) -> String {
        
        
        let difference = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: date, to: self)
        
        //        let seconds = "\(difference.second)s"
        //        let minutes = "\(difference.minute)m" + " " + seconds
        //        let hours = "\(difference.hour)h" + " " + minutes
        //        let days = "\(difference.day)d" + " " + hours
        
        //        let seconds = "\(difference.second)"
        let minutes = " \(String(difference.minute!)) น."
        var hours = ""
        if difference.minute == 0 {
            hours = "\(String(difference.hour!))" + " ชม."
        }else{
            hours = "\(String(difference.hour!))" + " ชม." + minutes
        }
        
        //        let days = "\(difference.day)" + " วัน" + hours
        
        //        if difference.day    >= 0 { return days }
        if difference.hour!   > 0 { return hours }
        if difference.minute! > 0 { return minutes }
        //        if difference.second > 0 { return seconds }
        return ""
    }
    
    func offsetFromFullAllDay(_ date:Date) -> String {
        
        
        let difference = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: date, to: self)
        
        //        let seconds = "\(difference.second)s"
        //        let minutes = "\(difference.minute)m" + " " + seconds
        //        let hours = "\(difference.hour)h" + " " + minutes
        //        let days = "\(difference.day)d" + " " + hours
        
        //        let seconds = "\(difference.second)"
        //        let minutes = " \(difference.minute) น."
        //        let hours = " \(difference.hour)" + " ชม." + minutes
        //        let days = "\((difference.day)+1)" + " วัน" + hours
        let days = "\((difference.day!)+1)" + " วัน"
        
        if difference.day!    >= 0 { return days }
        //        if difference.hour   > 0 { return hours }
        //        if difference.minute > 0 { return minutes }
        //        if difference.second > 0 { return seconds }
        return ""
    }
    

    
    func stringFromFormatCalendar(_ format: String,calendar: Calendar.Identifier) -> String {
        let formatter = DateFormatter()
//        formatter.locale = Locale.autoupdatingCurrent
        formatter.calendar = Calendar(identifier: calendar)
        
        formatter.locale = Locale(identifier: "th_TH")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    

}
