//
//  AdminConstants.swift
//  MaytroAdmin
//
//  Created by Mac-4 on 15/04/19.
//  Copyright © 2019 Mac-4. All rights reserved.
//

import Foundation

//let appDelegate = UIApplication.shared.delegate as! AppDelegate

struct Constants
{
//    MARK:APi  name
     static let get_all_country = "get_all_country"
     static let login = "login"
     static let forgot_password = "forgot_password"
     static let register = "register"
     static let resend_otp = "resend_otp"
     static let verify_otp = "verify_otp"
     static let get_user_profile = "get_user_profile"
     static let update_device_token = "update_device_token"
     static let update_profile = "update_profile"
     static let get_shops_types = "get_shops_types"
     static let update_vendor_address = "update_vendor_address"
     static let update_user_address = "update_user_address"
     static let change_password = "change_password"
     static let get_ads_list = "get_ads_list"
     static let get_nearby_shops = "get_nearby_shops"
     static let get_category_list = "get_category_list"
     static let get_category_by_type_id = "get_category_by_type_id"
     static let get_unit_list = "get_unit_list"
     static let get_type_list = "get_type_list"
     static let get_category_products = "get_category_products"
     static let get_features_list = "get_features_list"
     static let get_search_list = "get_search_list"
     static let get_inventry_search_list = "get_inventry_search_list"
     static let get_product_detail = "get_product_detail"
     static let get_cart_list = "get_cart_list"
     static let place_order = "place_order"
     static let get_upcoming_orders = "get_upcoming_orders"
     static let get_pending_orders = "get_pending_orders"
     static let get_order_detail = "get_order_detail"
     static let cancel_upcoming_order = "cancel_upcoming_order"
     static let quote_order = "quote_order"
     static let my_inventory_products = "my_inventory_products"
     static let add_inventory_item = "add_inventory_item"
     static let document_upload = "document_upload"
     static let update_item_status = "update_item_status"
     static let update_available_status = "update_available_status"
     static let get_notifications = "get_notifications"
     static let delete_notifications = "delete_notifications"
     static let get_notification_count = "get_notification_count"
     static let get_points = "get_points"
     static let update_user_language = "update_user_language"
     static let rate_feedback = "rate_feedback"
     static let get_rating_list = "get_rating_list"
     static let get_order_by_customer_id = "get_order_by_customer_id"
     static let update_credit_status = "update_credit_status"
    
     static let get_credit_user_balance = "get_credit_user_balance"
     static let get_credit_vendor_balance = "get_credit_vendor_balance"
     static let get_credit_orders = "get_credit_orders"
     static let my_offers = "my_offers"
     static let my_orders = "my_orders"
     static let view_quote = "view_quote"
     static let confirm_quote = "confirm_quote"
     static let confirm_payment = "confirm_payment"
     static let update_order_status = "update_order_status"
     static let get_contact_details = "get_contact_details"
     static let logout = "logout"
     static let terms_of_services = "terms_of_services"
     static let get_fullfilled_order = "get_fullfilled_order"
     static let canceled_order = "canceled_order"

     static let reset_password = "reset_password"
     static let search_orders = "search_orders"
    //MARK:- Message
    static let GET_PROFILE_OBSERVER = "GET PROFILE OBSERVER"
    static let PLEASE_WAIT = "PLEASE WAIT"
    static let No_Internet = "No Internet Connection"
    static let SomethingWentWrong = "Something went wrong. Please try again later"
    static let SomethingWentWrongNetwork = "Something went wrong. Please check your network connectivity."
    static let noProfile =  "Profile not complete Please complete your profile first"
    static let nolatlng =  "Profile updated successfully. Please update your shop details from the top right corner"
       static let PROFILE_UPDATE = "Profile Updated sucessful"//signup
    //MARK:- Validation

    //login signup forgot password
    static let noName = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Please enter your name")//signup
    static let noCountry = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Please select country")
    static let noMobile = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Please enter mobile number")
    static let noCheckBox = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Please accept terms and conditions")
    static let noMobileValid = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Please enter valid mobile number")
    static let noPassDigitValidation = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Password should contain atleast 6 character")//login signup
    static let noMobileDigit = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Mobile number should contain atleast 7 digits")
    
//    MyLocation
    static let noShopName = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Please enter shop name")
    static let noLocation = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Please enter all the information")
    static let noShopType = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Please select shop type")
    static let noShopLocation = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Please select shop location")
    static let noShopSelectLocation = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Please select the shop address")

    
    
    static let noFirmName = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Please enter your firm name")//signup
    static let noEmailMsg = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Please enter email")//login signup
    static let wrongEmailValidation = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Please enter valid email")//login signup
    static let noPassValidation = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Please enter password")//login signup
    static let invalidPassValidation = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Password length should be 6 digits")//signup
    static let noConfPassValidation = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Please enter confirm password")//signup
    static let invalidConfPassValidation = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Password and confirm password should be same")//signup
// add inventry item
    static let noCategory = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key: "Please select category")
    static let noItemName = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key: "Please enter item name")
    static let noBrand = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key: "Please enter brand name")
    static let noDetail = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key: "Please enter details")
    static let noUnit = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key: "Please select unit")
    static let noQty = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key: "Please enter quantity")
    static let noPrice = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key: "Please enter price")
    static let noSellingPrice = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key: "Please enter selling price")
     static let noImage = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key: "Please select image")
//    quote order
    static let norderCancel = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Please cancel order")

    static let noDateTime = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Please select date and time")
    
    static let deleteProduct = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Are you sure? You want to delete?")
    static let rcvPayment = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Are you sure? you have received payment?")
//Product Availability
    static let noPriceEnable = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Please enable product price in profile")



//upcoming order
    static let noconfirmation = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Are you sure? You want to cancel order?")
    //change password
    static let noOldPassword = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Please enter old password")
    static let noNewPassword = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Please enter new password")
    static let invalidNewPassConfPassValidation = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"New password and confirm password should be same")
    
    //create group
    static let noGroupName = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Please enter group name")
    
    static let wrongPassValidation = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Please enter valid password")
    static let noConfirmPassValidation = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Please enter confirm password")
    static let profileUpdatedSuccess = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"Profile is updated successfully")
    static let NoRecordFound = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"No record Found")
    static let dateValidation = Singleton.shared.LOCALIZED_STRING_FOR_KEY(key:"End Date should be greater than start date")
    

    
    //player
    static let noPlayerName = "Please enter player name"
    static let noPlayerPin = "Please enter player pin"
    static let noPlayerGroup = "Please select player group"
    static let noPlayerOrientation = "Please select player orientation"
    static let noPlayerDesc = "Please enter player description"

    //playlist
    static let noPlayListName = "Please enter playlist name"
    static let noPlayListAssets = "Please select atleast one asset"
    static let noPlayListDays = "Please select atleast one day"
    static let noPlayListTime = "Please select play time"
    static let noPlayListStartDate = "Please select start date"
    static let noPlayListEndDate = "Please select end date"

    static let deleteAlert = "Are you sure? You want to delete it?"
    static let logoutText = "Are you sure? You want to logout?"
    static let deleteAccount = "Are you sure? You want to delete your account?"
    static let inActiveAccount = "Your account is inactive. Please contact admin."
    static let deletedAccount = "Your account is deleted. Please register again."


    static let addTimer = "Please select time for image"
    static let adminPlaylist = "You can't schedule admin playlist"
    static let alreadySchedule = "Playlist already scheduled. Do you want to update it?"

    //SSJ
    static let selectInterest = "Please select at least 5 interest."
}
