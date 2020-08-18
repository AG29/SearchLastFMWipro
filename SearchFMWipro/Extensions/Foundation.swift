//
//  UserDefauts.swift
//  SearchFMWipro
//
//  Created by AG on 14/08/20.
//  Copyright © 2020 AG. All rights reserved.
//

import Foundation
import UIKit

extension URL
{
    func open()
    {
        UIApplication.shared.open(self, options: [:], completionHandler: nil)
    }
}

extension Date
{
    func string(format : String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  format
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    
    public var weekDay : String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "EEEE"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    
    public var time : String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "hh:mm a"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }

}

extension Double
{
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Data
{
    public var toDictionary : [String: Any]?
    {
        return try? JSONSerialization.jsonObject(with: self, options: []) as? [String: Any]
    }
    
    public var jsonString : String?
    {
        return String(data: self, encoding: .utf8)
    }
}

extension UserDefaults
{
    func saveObject(_ value: Any?, forKey key: String)
    {
        var encodedObject: Data? = nil
        if let anObject = value {
            encodedObject = NSKeyedArchiver.archivedData(withRootObject: anObject)
        }
        self.set(encodedObject, forKey: key )
        self.synchronize()
    }
    
    func readObject(forKey key: String) -> Any?
    {
        let encodedObject = self.object(forKey: key ) as? Data
        var object: Any? = nil
        if let anObject = encodedObject {
            object = NSKeyedUnarchiver.unarchiveObject(with: anObject)
        }
        return object
    }
}

extension NSCharacterSet
{
    var characters:[String]
    {
        var chars = [String]()
        for plane:UInt8 in 0...16
        {
            if self.hasMemberInPlane(plane)
            {
                let p0 = UInt32(plane) << 16
                let p1 = (UInt32(plane) + 1) << 16
                for c:UTF32Char in p0..<p1
                {
                    if self.longCharacterIsMember(c)
                    {
                        var c1 = c.littleEndian
                        let s = NSString(bytes: &c1, length: 4, encoding: String.Encoding.utf32LittleEndian.rawValue)!
                        chars.append(String(s))
                    }
                }
            }
        }
        return chars
    }
}

extension Array
{
    func randomItem() -> Element?
    {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}


extension CountableClosedRange
{
    var randomInt: Int
        {
        get
        {
            var offset = 0
            
            if (lowerBound as! Int) < 0   // allow negative ranges
            {
                offset = abs(lowerBound as! Int)
            }
            
            let mini = UInt32(lowerBound as! Int + offset)
            let maxi = UInt32(upperBound   as! Int + offset)
            
            return Int(mini + arc4random_uniform(maxi - mini)) - offset
        }
    }
}


extension String
{
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func dateWithFormat(_ format: String) -> Date?
    {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        if format == "HH:mm" || format == "hh:mm a" {
            return "\(Date().string(format: "dd/MM/yyyy")) \(self)".dateWithFormat("dd/MM/yyyy \(format)")
        }
        else {
            return formatter.date(from: self)
        }
    }

    func substring(_ from: Int) -> String {
        return self.substring(from: self.index(self.startIndex, offsetBy: from))
    }
        
    var isAllDigits : Bool
    {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = self.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  self == filtered
    }
    
    var trim : String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    func createAttributedString(subString: String, subStringColor: UIColor) -> NSMutableAttributedString
    {
        let range = (self as NSString).range(of: subString)
        let attributedString = NSMutableAttributedString(string:self)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: self.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: subStringColor, range: range)
        return attributedString
    }
}


