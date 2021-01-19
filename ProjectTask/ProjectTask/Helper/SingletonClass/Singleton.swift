//
//  Singleton.swift
//  RURProject
//
//  Created by WebvilleeMAC on 25/08/17.
//  Copyright © 2017 Webvillee. All rights reserved.
//

import UIKit
import MapKit

enum StoryboardType : String
{
    case main = "Main"
}
enum HTTP : Int
{
    case RESPONSE_SUCCESS = 200
    case RESPONSE_201 = 201
    case RESPONSE_202 = 202
    case RESPONSE_203 = 203
    case RESPONSE_204 = 204
    case RESPONSE_205 = 205
    case RESPONSE_401 = 401

    case RESPONSE_SERVER_ERROR = 500
    case RESPONSE_NOT_FOUND = 404
}

class Singleton: NSObject {
    
    static let shared  = Singleton()
    //let PLACEAPIKEY = "AIzaSyAgoWN33GC4DiIPcGM9zpqAP8WtR40b6BM" // FODO
    var dicNotification = NSDictionary()


    var USERID = ""
    var DEVICEID = UIDevice.current.identifierForVendor?.uuidString
    var USERTOKEN = ""
    var DEVICE_TOKEN = "1234"
    var USERROLE = "2"
    var DEVICE_TYPE = "2"
    
    
    func languageActive() -> String {
        return "English"
    }
    var strLandID = "eng"
    var isDebug = true
    var isFreshOpened = false
    var isNoMixerShown = true
    var isLoggedIn = false
    var isValidAppVersion = true
    var isTabBarAlreadyPresented = false
    
    var error = ""
    // user default :
    
    static let Price_Sign = "\u{20B9}"
    static let USERINFO = "USER_INFO"
    
    var DEEPLINKING_DATA = Dictionary<String,AnyObject>()
    var PUSH_DATA = Dictionary<String,Any>()
    var USER_SHOP_LAT = ""
    var USER_SHOP_LNG = ""
    var USER_SHOP_ADDRESS = ""
    let LOCATION_SELECTED = "locationSelectedNotification"
    
    
   
    func getCurrentUnixTime() -> String {
        let unixTime = String.init(format: "%f", NSDate().timeIntervalSince1970)
        let splitArray = unixTime.components(separatedBy: ".")
        print("Current unix timestamp \(splitArray[0])")
        return splitArray[0]
    }
    
    func getUnixTimeFrom(date:NSDate) -> String {
        let unixTime = String.init(format: "%f", date.timeIntervalSince1970)
        let splitArray = unixTime.components(separatedBy: ".")
        print("Current unix timestamp \(splitArray[0])")
        return splitArray[0]
    }
    
    func getUnixTimeFromString(date:String,format:String) -> String {
        
        let formatterTemp = DateFormatter()
        formatterTemp.dateFormat = format
        let date1 = formatterTemp.date(from: date)
        if date1 == nil {
            return ""
        }
        let unixTime = String.init(format: "%f", date1!.timeIntervalSince1970)
        let splitArray = unixTime.components(separatedBy: ".")
        print("Current unix timestamp \(splitArray[0])")
        return splitArray[0]
    }
    
    func getDateFrom(str:String,dateFormat:String) -> NSDate {
        
        let formatterTemp = DateFormatter()
        if dateFormat.count > 0 {
            formatterTemp.dateFormat = dateFormat //Your date format

        }else{
            formatterTemp.dateFormat = "dd/MM/yyyy" //Your date format
        }
        formatterTemp.timeZone = TimeZone.current
        let date = formatterTemp.date(from: str)
        return date! as NSDate
    }
    
    func convertDictionaryToJsonString(dict:Any) -> String {
        
        var jsonString = ""
        do {
            let data = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
            jsonString = String.init(data: data, encoding: .utf8)!
        } catch {
            print("Exception in convertDictToJSONString")
        }
        return jsonString
        
    }
    func stringConvertToArray(text: String) -> NSArray?
    {
        if let data = text.data(using: .utf8)
        {
            do
            {
                return try JSONSerialization.jsonObject(with: data, options: []) as? NSArray
            }
            catch
            {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func stringConvertToDictionary(text: String) -> NSDictionary? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func convertDateToOtherFormat(dateString:String, currentFormat:String,newFormat:String) -> String
    {
        let isoDate = dateString

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current //Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")! //Current time zone

        dateFormatter.dateFormat = currentFormat
        let date = dateFormatter.date(from:isoDate)!
        dateFormatter.timeZone = TimeZone.current //TimeZone(abbreviation: "UTC")

        dateFormatter.dateFormat = newFormat
        
        let dateStr = dateFormatter.string(from: date)
        
        return dateStr
    }
  
    
    
    
    func roundCornerButton(btn:UIButton,corner_rad:CGFloat)
    {
        btn.layer.cornerRadius = corner_rad
        btn.layer.shadowColor = btn.backgroundColor?.cgColor
        btn.layer.shadowRadius = 1
        btn.layer.shadowOffset = CGSize.init(width: 2, height: 5)
        btn.layer.shadowOpacity = 0.2
    }
 
    func topRoundCorners(cornerRadius: Double, view : UIView) {
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = path.cgPath
        view.layer.mask = maskLayer
    }
    
    func addShadowInView(view:UIView , borderColor:UIColor , borderWidth : CGFloat , shadowColor:UIColor ,shadowRadius : CGFloat)  {
        view.layer.borderColor = borderColor.cgColor
        view.layer.borderWidth = borderWidth
        view.layer.shadowColor = shadowColor.cgColor
        view.layer.shadowRadius = shadowRadius
        view.layer.shadowOffset = CGSize.init(width: 3, height: 5)
        view.layer.shadowOpacity = 0.1
    }
    
   
    
    func convertTimeStampToDate(timeStamp:String , withTime:Bool , dateFormat:String , timeFormat:String) -> String {
        
        var timeSta = Double(timeStamp)
        if timeSta == nil {
            timeSta = Double(Singleton.shared.getCurrentUnixTime())
        }
        let interval = TimeInterval.init(timeSta!)
        let date = Date.init(timeIntervalSince1970: interval)
        let formatter = DateFormatter.init()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        if !withTime {
            formatter.dateFormat = dateFormat
            
        }else{
            formatter.dateFormat = "\(dateFormat) \(timeFormat)"
            
        }
        return formatter.string(from: date);
        
    }
    
    
    
    
    func formatPhoneNumber(_ simpleNum: String, deleteLastChar: Bool) -> String {
        var simpleNumber = simpleNum
        if (simpleNumber.count ) == 0 {
            return ""
        }
        // use regex to remove non-digits(including spaces) so we are left with just the numbers
        let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive)
        simpleNumber = (regex?.stringByReplacingMatches(in: simpleNumber, options: [], range: NSRange(location: 0, length: (simpleNumber.count )), withTemplate: ""))!
        // check if the number is to long
        
        if (simpleNumber.count ) > 10 {
            // remove last extra chars.
            //simpleNumber = ((simpleNumber as? NSString)?.substring(from: simpleNumber.length - 1))!
            let length = Int(simpleNumber.count )
            if length > 10 {
                simpleNumber = ((simpleNumber as? NSString)?.substring(from: length - 10))!
            }
            
        }
        if deleteLastChar {
            // should we delete the last digit?
            simpleNumber = ((simpleNumber as? NSString)?.substring(to: (simpleNumber.count ) - 1))!
            
        }
        if simpleNumber.count < 7 {
            simpleNumber = (simpleNumber as NSString).replacingOccurrences(of: "(\\d{3})(\\d+)", with: "RM1-RM2", options: .regularExpression, range: NSRange(location: 0, length: simpleNumber.count))
        }
        else {
            // else do this one..
            simpleNumber = (simpleNumber as NSString).replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "RM1-RM2-RM3", options: .regularExpression, range: NSRange(location: 0, length: simpleNumber.count))
        }
        return simpleNumber
    }
    
    
    class func convertToString(convert:Any) -> String {
        
        return String.init(format: "%@", convert as! CVarArg)
        
    }
    
    class func convertTimeFormatTo24Hour(time:String) -> String {
        if time == "" {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        let date = formatter.date(from: time)
        formatter.dateFormat = "HH:mm:ss"
        formatter.timeZone = TimeZone.current
        if date == nil {
            return time
        }
        return formatter.string(from: date!)
        
    }
    
    class func convertMemberSince(timeStamp:String) -> String {
        
        var timeSta = Double(timeStamp)
        if timeSta == nil {
            timeSta = Double(Singleton.shared.getCurrentUnixTime())
        }
        let interval = TimeInterval.init(timeSta!)
        let date = Date.init(timeIntervalSince1970: interval)
        let formatter = DateFormatter.init()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd MMM yyyy"
            
       
        let dateNew = formatter.string(from: date);
        let arrDate = dateNew.components(separatedBy: " ")
        
        return "Member since \(arrDate[1])'\(arrDate[2].suffix(2))"
    }
    
    class func convertTimeFormatTo12Hour(time:String) -> String {
        if time == "" {
            return ""
        }
        let formatter = DateFormatter()
        let arrTime = time.components(separatedBy: ":")
        formatter.dateFormat = "HH:mm:ss"
        if arrTime.count == 2 {
            formatter.dateFormat = "HH:mm"
        }
        formatter.timeZone = TimeZone.current
        
        let date = formatter.date(from: time)
        
        formatter.dateFormat = "hh:mm a"
        if date == nil {
            return time
        }
        return formatter.string(from: date!).lowercased()
        
    }
    
    class func convertDateFormat(date:String,format:String,oldFormat:String) -> String {
        if date.count == 0 {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = oldFormat
        formatter.locale = .current
        formatter.timeZone = TimeZone.current
        let date1 = formatter.date(from: date)
        formatter.dateFormat = format
        return formatter.string(from: date1!)
        
    }
    
    class func formatDate(date: Date ,time : Bool , dateFormat:String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.timeZone = TimeZone.current
        if time {
            dateFormatter.dateStyle = .short
            dateFormatter.dateFormat = "hh:mm a"
        }else{
            dateFormatter.dateFormat = dateFormat
        }
        
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate;
        
    }
    
    
    
    class func isValidEmail(_ enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
  class  func isValid(testStr:String) -> Bool {
        guard testStr.count >= 1, testStr.count < 65 else { return false }
        
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
        return predicateTest.evaluate(with: testStr)
    }
    
    class func openURLinSafari(url:String){
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
   class func stringSpaceValidation(string: String) -> Bool {
           return string.rangeOfCharacter(from: CharacterSet.whitespaces) == nil
       }
    func modify(txtFld:UITextField,withimage:String,borderColor:UIColor?,borderWidth:CGFloat?,cornerRadius:CGFloat?) {
        if borderWidth != nil{
            txtFld.layer.borderWidth = borderWidth!
        }else{
            txtFld.layer.borderWidth = 1
        }
        if cornerRadius != nil {
            txtFld.layer.cornerRadius = cornerRadius!
        }else{
            txtFld.layer.cornerRadius = 1
        }
        if borderColor != nil {
            txtFld.layer.borderColor = borderColor?.cgColor
        }else{
            txtFld.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1).cgColor
        }
        
        if withimage.count > 0 {
            let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 15, height: txtFld.frame.size.height))
            view.backgroundColor = .clear
            
            let icon = UIImageView.init(frame: CGRect.init(x: 10, y: 12, width: 15, height: 15))
            icon.image = UIImage.init(named: withimage)
            icon.contentMode = .scaleAspectFit
            view.addSubview(icon)
            txtFld.leftView = view
            txtFld.leftViewMode = .always
        }else{
            let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: txtFld.frame.size.height))
            view.backgroundColor = .clear
            txtFld.leftView = view
            txtFld.leftViewMode = .always
        }
        
    }
    
    class func saveUserInfoInUserdefault(userDict:Any , withKey:String){
        let data = NSKeyedArchiver.archivedData(withRootObject: userDict)
        UserDefaults.standard.set(data, forKey: withKey)
    }
    
    class func getUserInfoFromUserdefault(withKey:String) -> NSDictionary {
        let data = UserDefaults.standard.object(forKey: withKey) as! Data
        let userDict = NSKeyedUnarchiver.unarchiveObject(with: data) as! NSDictionary
        return userDict
    }
    class func getValueFromUserInfo(withKey:String) -> String {
        if isKeyPresentInUserDefaults(key: Singleton.USERINFO) {
            let dicTemp = Singleton.getUserInfoFromUserdefault(withKey: Singleton.USERINFO)
            let dicData = dicTemp.value(forKey: "data") as! NSDictionary
            return "\(dicData.object(forKey: withKey) ?? "")"
        }else{
            return ""
        }
        
    }
    
    class func updateUserDictionaryForKey(key:String,withValue:String,storedKey:String){
        
        if Singleton.isKeyPresentInUserDefaults(key: storedKey) {
            let resultData = UserDefaults.standard.object(forKey: storedKey) as! Data
            let dictTemp = NSKeyedUnarchiver.unarchiveObject(with: resultData) as! NSDictionary
            let dict = dictTemp.mutableCopy() as! NSMutableDictionary
            if dict.count > 0 {
                if (dict.object(forKey: key) != nil) {
                    dict.setValue(withValue, forKey: key)
                    
                    let data = NSKeyedArchiver.archivedData(withRootObject: dict)
                    UserDefaults.standard.set(data, forKey: storedKey)
                    UserDefaults.standard.synchronize()
                    print("User dict updated for key \(key)")
                }
            }else{
                
            }
        }
    }
    
    
    class func getUserInfoFor(itemKey:String , storedKey:String) -> Any? {
        
        if Singleton.isKeyPresentInUserDefaults(key: storedKey) {
            let resultData = UserDefaults.standard.object(forKey: storedKey) as! Data
            let dictTemp = NSKeyedUnarchiver.unarchiveObject(with: resultData) as! NSDictionary
            print("user info ", dictTemp)
            let dict = dictTemp.mutableCopy() as! NSMutableDictionary
            if dict.count > 0 {
                if (dict.object(forKey: itemKey) != nil) {
                    return dict.object(forKey: itemKey)
                }
            }else{
                
            }
        }
        return nil
    }
    
    class func removeDataFromUserInfoWith(key:String) {
        UserDefaults.standard.set(nil, forKey: key)
    }
    func getDistanceInMiles(kilometer:String) -> String {
        let distance = Double(kilometer)
        let distanceMiles = distance! * 0.621371
        if distanceMiles > 999 {
            return String.init(format: ">999 mi", distanceMiles)
        }else{
            return String.init(format: "%.1f mi", distanceMiles)
        }
        
    }

    
    func LOCALIZED_STRING_FOR_KEY(key:String) -> String {
        
        if UserDefaults.standard.string(forKey: "language") == "arb"
        {
            let str = Bundle.main.localizedString(forKey: key, value: nil, table: "Arabic") as? String
            
            if (str==nil)
            {
                return key;
            }
            else
            {
                return str!;
            }
        }
        else if UserDefaults.standard.string(forKey: "language") == "kn-IN"
        {
            let str = Bundle.main.localizedString(forKey: key, value: nil, table: "Kannada") as? String
            
            if (str==nil)
            {
                return key;
            }
            else
            {
                return str!;
            }
        }else{
            let str = Bundle.main.localizedString(forKey: key, value: nil, table: "English") as? String
            
            if (str==nil)
            {
                return key;
            }
            else
            {
                return str!;
            }
        }
    }
    
    //Check user default value
    class func isKeyPresentInUserDefaults(key: String) -> Bool
    {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    
    // =================================
    
    class func actionShowAlertWith(AlertTitle: String, Message : String, ButtonOfArrayInString : [String] , compblock: @escaping (String)-> Void){
        
        AlertViewS.ShowAlertTitle(AlertTitle: AlertTitle, Message: Message, ThemeColor: [AppDelegate.shared().APP_COLOR, AppDelegate.shared().APP_COLOR], BtnAlignmentType:.Horizontal, ButtonOfArrayInString: ButtonOfArrayInString as NSArray) { (result) in
                compblock(result)
        }
    }
    
    //displayAlertWithImage
//
    class func actionShowAlertWithImage(AlertImg : UIImage , AlertTitle: String, Message : String, ButtonOfArrayInString : [String] , compblock: @escaping (String)-> Void){

        AlertViewS.ShowAlertTitleWithImage(AlertImage :AlertImg,AlertTitle: AlertTitle, Message: Message, ThemeColor: [AppDelegate.shared().APP_COLOR, AppDelegate.shared().APP_COLOR], BtnAlignmentType:.Horizontal, ButtonOfArrayInString: ButtonOfArrayInString as NSArray) { (result) in
            compblock(result)
        }
    }
    
    
    class func actionShowNetwotkError( compblock: @escaping (String)-> Void){
        
//        AlertViewS.ShowAlertTitle(AlertTitle: "Alert", Message:Constants.SomethingWentWrongNetwork, ThemeColor: [(  AppDelegate.shared().APP_COLOR)], BtnAlignmentType:.Horizontal, ButtonOfArrayInString: ["Cancel", "Retry"]) { (result) in
//            if result == "Retry" {
//                compblock("Retry")
//            }
//        }
    }
    class func actionMessageWithButtons(message : String,arrButton:NSArray, compblock: @escaping (String)-> Void)
    {
        
        AlertViewS.ShowAlertTitle(AlertTitle: "", Message:message, ThemeColor: [(  AppDelegate.shared().APP_COLOR)], BtnAlignmentType:.Horizontal, ButtonOfArrayInString: arrButton) { (result) in
           
                compblock(result)
            
        }
    }
    class func actionShowAlertWithSingleButton(message : String,buttonTitle : String, compblock: @escaping (String)-> Void){
        
        AlertViewS.ShowAlertTitle(AlertTitle: "", Message:message, ThemeColor: [(  AppDelegate.shared().APP_COLOR)], BtnAlignmentType:.Horizontal, ButtonOfArrayInString: [buttonTitle]) { (result) in
            if result == "OK" {
                compblock("OK")
            }
        }
    }
    
   class func actionShowServerMessageError(message : String){
    
        AlertViewS.ShowAlertTitle(AlertTitle: "Alert", Message: message, ThemeColor: [ AppDelegate.shared().APP_COLOR], BtnAlignmentType: .Horizontal, ButtonOfArrayInString: ["OK"]) { (result) in
        }
    }
    
    class func actionShowMessage(message : String){
        
        AlertViewS.ShowAlertTitle(AlertTitle: "", Message: message, ThemeColor: [ AppDelegate.shared().APP_COLOR], BtnAlignmentType: .Horizontal, ButtonOfArrayInString: ["OK"]) { (result) in
        }
    }
    
    class func actionShowAlertWithAttributeText( AlertTitle: String, AtributeMsg:NSMutableAttributedString , ButtonOfArrayInString : [String] , compblock: @escaping (String)-> Void){
        
        AlertViewS.ShowAlertTitleWithAtributeText(AlertTitle: AlertTitle, AtributeMsg: AtributeMsg, ThemeColor: [AppDelegate.shared().APP_COLOR, AppDelegate.shared().APP_COLOR], BtnAlignmentType: .Horizontal, ButtonOfArrayInString: ButtonOfArrayInString as NSArray) { (result) in
             compblock(result)

        }
    }
    
    func noDuplicates(_ arrayOfDicts: [[String: Any]] , withKey:String, orWithKey:String) -> [[String: Any]] {
        var noDuplicates = [[String: Any]]()
        var arrID = [String]()
        for dict in arrayOfDicts {
            let id = "\(dict[withKey] ?? dict[orWithKey] ?? "")"
            if id.count == 0 {
                
            }
            //let id = String.init(format: "%@", dict[withKey] as! CVarArg)
            if !arrID.contains(id) {
                noDuplicates.append(dict)
                arrID.append(id)
            }
        }
        print(arrID)
        return noDuplicates
    }
    
    
    
    //MARK: - Get Info
    
    func getValueOfSingleStoredValue(key:String) -> String {
        let data = UserDefaults.standard.object(forKey: key) as! Data
        let value = "\(NSKeyedUnarchiver.unarchiveObject(with: data) ?? "")"
        return value
    }
    
    class func convertUTCDate(date:String, newDateFormat:String) -> String {


        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let convertedDate = formatter.date(from: date)
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = newDateFormat
        return formatter.string(from: convertedDate!)
    }
    
    func UTCToLocal(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "h:mm a"
        
        return dateFormatter.string(from: dt!)
    }
    
    
}







