//
//  AppExtensions.swift
//  MixerApp
//
//  Created by wvmac2 on 04/10/19.
//  Copyright © 2019 Webvillee. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func addingPercentEncodingForQuery() -> String? {
        let allowed = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._* ")
        return addingPercentEncoding(withAllowedCharacters: allowed)?.replacingOccurrences(of: " ", with: "+")
    }
    
    func localizedString() -> String
    {
        return Singleton.shared.LOCALIZED_STRING_FOR_KEY(key: self)
    }

    func isValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.width
    }
    
    func printOn(){
        if Singleton.shared.isDebug {
            print(self)
        }
    }
    subscript(_ range: CountableRange<Int>) -> String
    {
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
    }
    
}

extension URL {
    func downloaded_file(completionHandler: @escaping (URL?) -> Swift.Void)   {
        URLSession.shared.dataTask(with: self) { data, response, error in
            guard let data = data, error == nil else { return }
            let tmpURL = FileManager.default.temporaryDirectory
                .appendingPathComponent(response?.suggestedFilename ?? "fileName.pdf")
            do {
                try data.write(to: tmpURL)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                completionHandler(tmpURL)
            }
            }.resume()
        
    }
    
}

extension Double
{
    var clean: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        return formatter.string(from: self as NSNumber) ?? "0"
    }
}

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
    
    var age: Int {
        let calendar: Calendar = Calendar.current
        let now = calendar.startOfDay(for: Date())
        let birthdate = calendar.startOfDay(for: self)
        let components = calendar.dateComponents([.year], from: birthdate, to: now)
        return components.year ?? 0
    }
}

@IBDesignable
class RightAlignedIconButton: UIButton {
    override func layoutSubviews() {
        //        super.layoutSubviews()
        //        semanticContentAttribute = .forceRightToLeft
        //        contentHorizontalAlignment = .right
        //        let availableSpace = UIEdgeInsetsInsetRect(bounds, contentEdgeInsets)
        //        let availableWidth = availableSpace.width - imageEdgeInsets.left - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
        //        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: availableWidth / 2)
    }
}



class CustomizedBundle: Bundle {
    var kAssociatedLanguageBundle = 0
    
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        let bundle = objc_getAssociatedObject(self, &kAssociatedLanguageBundle) as? Bundle
        
        return (bundle != nil) ? bundle!.localizedString(forKey: key, value: value, table: tableName) : super.localizedString(forKey: key, value: value, table: tableName)
        
        
    }
    
    
}
extension UILabel {
    
    func setLineHeight(lineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            
            style.lineSpacing = lineHeight
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, text.count))
            self.attributedText = attributeString
        }
    }
}
extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        
        let textContainerOffset = CGPoint(x:(labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}

extension UIView {
    
    func addDashedBorder(color:CGColor,isVerticle:Bool) {
        //Create a CAShapeLayer
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 1
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [5,2]
        
        let path = CGMutablePath()
        if isVerticle {
            path.addLines(between: [CGPoint(x: 0, y: 0),
                                    CGPoint(x: self.frame.width, y: 0)])
        }else{
            path.addLines(between: [CGPoint(x: 0, y: 0),
                                    CGPoint(x: 0, y: self.frame.height)])
        }
        
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
        layer.masksToBounds = true
    }
}

extension DateFormatter {
    func dateFromServer(dateString: String ,newFormat:String) -> String
    {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat =  "yyyy-MM-dd"
        let showDate = inputFormatter.date(from: dateString)
        inputFormatter.dateFormat = newFormat
        let resultString = inputFormatter.string(from: showDate!)
        print(resultString)
        
        
        
        return resultString
        //        // SWAPI dates look like: "2014-12-10T16:44:31.486000Z"
        //        self.dateFormat =  newFormat//"yyyy-MM-dd'T'HH:mm:ss.SZ"
        //        self.timeZone = TimeZone(abbreviation: "UTC")
        //        self.locale = Locale(identifier: "en_US_POSIX")
        //        let dateN =  self.date(from: dateString)
        //        return self.string(from: dateN!)
    }
    
    func dateFromServerWithTandZ(dateString: String ,newFormat:String) -> String
    {
        //        // SWAPI dates look like: "2014-12-10T16:44:31.486000Z"
        self.dateFormat =  newFormat//"yyyy-MM-dd'T'HH:mm:ss.SZ"
        self.timeZone = TimeZone(abbreviation: "UTC")
        self.locale = Locale(identifier: "en_US_POSIX")
        let dateN =  self.date(from: dateString)
        return self.string(from: dateN!)
    }
}

extension URLRequest {
    
    /// Populate the HTTPBody of `application/x-www-form-urlencoded` request
    ///
    /// - parameter parameters:   A dictionary of keys and values to be added to the request
    
    mutating func setBodyContent(_ parameters: [String : String]) {
        let parameterArray = parameters.map { (key, value) -> String in
            return "\(key.addingPercentEncodingForQuery()!)=\(value.addingPercentEncodingForQuery()!)"
        }
        httpBody = parameterArray.joined(separator: "&").data(using: .utf8)
    }
    
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}

class MYTextField: UITextField
{
    override func deleteBackward() {
        super.deleteBackward()
        delegate?.textFieldShouldReturn!(self)
        print("_____________BACKSPACE_PRESSED_____________")
    }
}

extension Collection {
    public func chunk(n: Int) -> [SubSequence] {
        var res: [SubSequence] = []
        var i = startIndex
        var j: Index
        while i != endIndex {
            j = index(i, offsetBy: n, limitedBy: endIndex) ?? endIndex
            res.append(self[i..<j])
            i = j
        }
        return res
    }
}

extension UIViewController {

    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)

        navigationController?.pushViewController(viewControllerToPresent, animated: false)
    }

    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)

        navigationController?.popViewController(animated: false)
        
    }
}


//
//  ExtensionNSObject.swift
//
//

import Foundation
public extension NSObject{
    public class var nameOfClass: String{
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    public var nameOfClass: String{
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
}




extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}


// An attributed string extension to achieve colors on text.
extension NSMutableAttributedString {

    func setColor(color: UIColor, forText stringValue: String) {
       let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }

}
