//
//  Application Preference.swift
//  Kumele
//
//  Created by WV-mac3 on 24/08/20.
//  Copyright © 2020 apple. All rights reserved.
//


import Foundation
import UIKit

protocol ApplicationPreferenceHandler {
    func read(type:PreferenceType) -> Any
    func write(type:PreferenceType,value: Any)
    func clearData(type:PreferenceType)
}

enum PreferenceType :String {
    
    case appLaunchFirstTime

    case logindata
    case Authorization
    case appLangKey
    case deviceId
    case user_id
    case redirect_to_verify
    case notification_unread_count
    case fcmToken
    case profile_complete
    case phoneNumber
    case timeZone
    case FirstName
    case LastName
    case isLocationEnable

    case isFromSignUpRedirection

    case isMinorUpdateCheckOneTIme

    var description : String {
        
        switch self {
        case .appLaunchFirstTime: return "appLaunchFirstTime"
        case .logindata: return "logindata"
        case .Authorization: return "Authorization"
        case .appLangKey : return "AppLangKey"
        case .deviceId : return "device_id"
        case .user_id : return "user_id"
        case .redirect_to_verify : return "redirect_to_verify"
        case .notification_unread_count : return "notification_unread_count"
        case .fcmToken: return "fcmToken"
        case .profile_complete: return "profile_complete"
        case .phoneNumber: return "phoneNumber"
        case .timeZone: return "timeZone"
        case .FirstName: return "FirstName"
        case .LastName: return "LastName"
        case .isFromSignUpRedirection: return "isFromSignUpRedirection"
        case .isLocationEnable: return "isLocationEnable"
            
        case .isMinorUpdateCheckOneTIme: return "isMinorUpdateCheckOneTIme"

        }
    }
}

class ApplicationPreference {
    
    fileprivate static let userDefault = UserDefaults.standard
    
    static var sharedManager: ApplicationPreference {
        return ApplicationPreference()
    }
}

extension ApplicationPreference:ApplicationPreferenceHandler{
    
    func clearData(type: PreferenceType) {
        ApplicationPreference.userDefault.removeObject(forKey: type.description)
        ApplicationPreference.userDefault.synchronize()
    }
      
    func write(type: PreferenceType, value: Any) {
        ApplicationPreference.userDefault.set(value, forKey: type.description)
        ApplicationPreference.userDefault.synchronize()
    }
    
    func read(type: PreferenceType) -> Any {
        return ApplicationPreference.userDefault.object(forKey: type.description) ?? ""
    }
    
    func clearDataOnLogout() {
        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.logindata.description)
        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.Authorization.description)
        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.redirect_to_verify.description)
        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.user_id.description)
        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.notification_unread_count.description)
        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.phoneNumber.description)
        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.timeZone.description)
        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.FirstName.description)
        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.LastName.description)
        
        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.isFromSignUpRedirection.description)

        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.isLocationEnable.description)
        
        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.isMinorUpdateCheckOneTIme.description)


        ApplicationPreference.userDefault.synchronize()
    }
    
    func clearAllData() {
        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.appLaunchFirstTime.description)
        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.logindata.description)
        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.Authorization.description)
        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.redirect_to_verify.description)
        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.user_id.description)
        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.notification_unread_count.description)
        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.phoneNumber.description)
        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.timeZone.description)
        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.FirstName.description)
        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.LastName.description)
        
        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.isLocationEnable.description)
        
        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.isFromSignUpRedirection.description)
        
        ApplicationPreference.userDefault.removeObject(forKey: PreferenceType.isMinorUpdateCheckOneTIme.description)


        ApplicationPreference.userDefault.synchronize()
    }
}
