//
//  WebserviceCall_Swift.swift
//  RURProject
//
//  Created by WebvilleeMAC on 23/08/17.
//  Copyright © 2017 Webvillee. All rights reserved.
//

import UIKit
import Foundation
import CoreGraphics

class WebserviceCall_Swift: NSObject,URLSessionTaskDelegate,URLSessionDataDelegate,URLSessionDelegate {
    var delegatee:AnyObject?
    var callBackk:Selector?
    //var sessionService:URLSession?
    var failedSession:URLSession?
    var recieveData = Data()
    var appDel = UIApplication.shared.delegate as! AppDelegate
    static let shared = WebserviceCall_Swift()
//    let KEY_GOOGLE = " AIzaSyCuO_c7uc091L6fL5mV9jPxezhCZdOOZdE "
    let KEY_GOOGLE = ""

    let boundary = "Boundary-\(UUID().uuidString)"
    
    static let server_url = "http://webvilleedemo.xyz:4000/api/"
    static let image_url = "http://webvilleedemo.xyz:4000/"
    
    let privacy_url = "http://3.14.202.215/admin/privacyPolicy"
    let terms_url = "http://3.14.202.215/admin/termCondition"

    func initWithDelegate(delegate:AnyObject , callBack:Selector) -> Any
    {
        delegatee = delegate
        callBackk = callBack
        return self
    }
    
    func retryService()
    {
        _ = failedSession
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data)
    {
        print(data)
        //  print(recieveData)
        
        // recieveData.append(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?)
    {
        if (error != nil)
        {
            failedSession = session
            _ =  delegatee?.perform(callBackk, with: "error")
            //print("didCompleteWithError \(error)")
        }else
        {
            //            do {
            //                _ = try JSONSerialization.jsonObject(with: recieveData, options: JSONSerialization.ReadingOptions.allowFragments)
            //
            //                print(json)
            //                recieveData = Data()
            //            } catch  {
            //                _ =  delegatee?.perform(callBackk, with: "error")
            //                recieveData = Data()
            //                print("error")
            //            }
        }
    }
    
   func callServiceWith(parameterDict:Dictionary<String, Any>,isAuth:Bool = false , url:String,type:String, onCompletion: @escaping (AnyObject)-> Void){
       if !Reachability.isConnectedToNetwork(){
           // _ =  self.delegatee?.perform(self.callBackk, with: "No Internet Connection")
           onCompletion("No Internet Connection" as AnyObject)
           return
       }
       else{
           let url = URL(string: WebserviceCall_Swift.server_url + url)!
           print("REQUEST JSON ",parameterDict,url)
           
           let session = URLSession.shared
           
           var request = URLRequest(url: url)
           request.httpMethod = type
           
            if type == "GET"
           {
               
           }
           else
            {
                if type.lowercased() == "post"
                {
                    request.setBodyContent(parameterDict as! [String : String] )
                }
            }
           
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           //request.setValue("*/*", forHTTPHeaderField: "accept")
           
            if isAuth
           {
               request.setValue(Singleton.shared.USERTOKEN, forHTTPHeaderField: "token")
            
            print("token == dict with array api ",Singleton.shared.USERTOKEN)
           }
           
           let task = session.dataTask(with: request as URLRequest) {data,response,error in
               let httpResponse = response as? HTTPURLResponse
               var lastPath = ""
               
               if httpResponse != nil
               {
                   lastPath =  (httpResponse?.url?.lastPathComponent)!
               }
               
               if (error != nil)
               {
                   print(error!)
                   //_ =  self.delegatee?.perform(self.callBackk, with: "error")
                   //print("string data \(String(data: data!, encoding: String.Encoding.utf8) ?? "")")
                   
                   onCompletion("error" as AnyObject)
                   
               }
               else
               {
                   //print(httpResponse!)
                   do
                   {
                       let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                       print("resulted json", json)
                       
                       //                        _ =  self.delegatee?.perform(self.callBackk, with: [json,lastPath] as NSArray)
                       onCompletion([json,lastPath] as NSArray)
                       
                   }
                   catch
                   {
                       print("string data \(String(data: data!, encoding: String.Encoding.utf8) ?? "")")
                       print("json error: \(error)")
                       //                        _ =  self.delegatee?.perform(self.callBackk, with: "error")
                       onCompletion("error" as AnyObject)
                       
                   }
               }
               
               
           }
           task.resume()
           
           
       }
   }
    
    func serviceCallWithFullURL(parameterDict:Dictionary<String, String> , url:String )
    {
        if !Singleton.shared.isValidAppVersion  {
            _ =  self.delegatee?.perform(self.callBackk, with: [["status":"301"],url] as NSArray)
        }else{
            let url = URL(string: url)!
            print("REQUEST JSON ",parameterDict,url)
            var req = URLRequest.init(url: url)
            req.httpMethod = "POST"
            req.timeoutInterval = 120
            
            //req.setValue(postLength, forHTTPHeaderField: "Content-Length")
            req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            req.setValue("application/json", forHTTPHeaderField: "Accept")
            req.setBodyContent(parameterDict)
            
            let sessionConf = URLSessionConfiguration.default
            let session = URLSession.init(configuration: sessionConf)
            let dataTask = session.dataTask(with: req as URLRequest) {data,response,error in
                let httpResponse = response as? HTTPURLResponse
                var lastPath = ""
                
                if httpResponse != nil
                {
                    lastPath =  (httpResponse?.url?.lastPathComponent)!
                }
                
                if (error != nil)
                {
                    print(error!)
                    _ =  self.delegatee?.perform(self.callBackk, with: "error")
                    
                }
                else
                {
                    //print(httpResponse!)
                    do
                    {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        print("resulted json", json)
                        
                        _ =  self.delegatee?.perform(self.callBackk, with: [json,lastPath] as NSArray)
                    }
                    catch
                    {
                        print("json error: \(error)")
                        _ =  self.delegatee?.perform(self.callBackk, with: "error")
                    }
                }
                
                DispatchQueue.main.async
                    {
                        //Update your UI here
                }
            }
            
            dataTask.resume()
        }
    }
    
    func serviceCall(parameterDict:Dictionary<String, String> , url:String )
    {
        if !Singleton.shared.isValidAppVersion  {
            _ =  self.delegatee?.perform(self.callBackk, with: [["status":"301"],url] as NSArray)
        }else{
        let url = URL(string: WebserviceCall_Swift.server_url + url)!
        print(url)
        var req = URLRequest.init(url: url)
        req.httpMethod = "POST"
        req.timeoutInterval = 120
        
        //req.setValue(postLength, forHTTPHeaderField: "Content-Length")
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        req.setBodyContent(parameterDict)
        
        let sessionConf = URLSessionConfiguration.default
        let sessionService = URLSession.init(configuration: sessionConf)
        let dataTask = sessionService.dataTask(with: req as URLRequest) {data,response,error in
            let httpResponse = response as? HTTPURLResponse
            var lastPath = ""
          
            if httpResponse != nil
            {
                lastPath =  (httpResponse?.url?.lastPathComponent)!
            }
            
            if (error != nil)
            {
                print(error!)
                _ =  self.delegatee?.perform(self.callBackk, with: "error")
                
            }
            else
            {
                //print(httpResponse!)
                do
                {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    print("resulted json", json)
                    
                    _ =  self.delegatee?.perform(self.callBackk, with: [json,lastPath] as NSArray)
                }
                catch
                {
                    print("json error: \(error)")
                    _ =  self.delegatee?.perform(self.callBackk, with: "error")
                }
            }
            
            DispatchQueue.main.async
                {
                //Update your UI here
            }
        }
        
        dataTask.resume()
        }
    }
    
   
    
    
    func serviceCallWithFullURL(image:UIImage,url:String ,parameterDict:Dictionary<String, String>,image_upload_key:String) {
        
        let url = URL(string: url)!
        print(url)
        var req = URLRequest.init(url: url)
        req.httpMethod = "POST"
        req.timeoutInterval = 300
        
        req.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let body = createBody(parameters: parameterDict, boundary: boundary, data: image.jpegData(compressionQuality: 0.5)!, mimeType: "image/jpg",
                              filename: "business.jpg",img_key:image_upload_key)
        print(body)
        req.httpBody =   body
        
        let postLength = "\(body.count)"
        req.setValue(postLength, forHTTPHeaderField: "Content-Length")
        let sessionConf = URLSessionConfiguration.default
        let sessionService = URLSession.init(configuration: sessionConf)
        let dataTask = sessionService.dataTask(with: req as URLRequest) {data,response,error in
            let httpResponse = response as? HTTPURLResponse
            var lastPath = ""
            if httpResponse != nil{
                lastPath =  (httpResponse?.url?.lastPathComponent)!
            }
            
            if (error != nil) {
                print(error!)
                _ =  self.delegatee?.perform(self.callBackk, with: "error")
                
            } else {
                //print(httpResponse!)
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    print(json)
                    
                    _ =  self.delegatee?.perform(self.callBackk, with: [json,lastPath] as NSArray)
                    
                } catch {
                    print("json error: \(error)")
                    _ =  self.delegatee?.perform(self.callBackk, with: "error")
                }
            }
            DispatchQueue.main.async {
                //Update your UI here
            }
        }
        dataTask.resume()
    }
    
    func serviceCallWithMultipleImage(images:[UIImage],url:String ,parameterDict:Dictionary<String, String>,image_upload_key:String,profile_img:UIImage?,profile_img_key:String){
        
        let url = URL(string: WebserviceCall_Swift.server_url + url)!
        print(url)
        var req = URLRequest.init(url: url)
        req.httpMethod = "POST"
        req.timeoutInterval = 1000
        req.setValue("multipart/form-data; boundary=0xKhTmLbOuNdArY", forHTTPHeaderField: "Content-Type")
        
        let body = createMultipleBody(parameters: parameterDict, boundary: boundary, images:images, mimeType: "image/jpg",filename: "",img_key:image_upload_key, profileImg: profile_img, profileImgKey: profile_img_key)
        print(body)
        req.httpBody =   body
        
        let postLength = "\(body.count)"
        req.setValue(postLength, forHTTPHeaderField: "Content-Length")
        let sessionConf = URLSessionConfiguration.default
        let sessionService = URLSession.init(configuration: sessionConf)
        let dataTask = sessionService.dataTask(with: req as URLRequest) {data,response,error in
            let httpResponse = response as? HTTPURLResponse
            var lastPath = ""
            if httpResponse != nil{
                lastPath =  (httpResponse?.url?.lastPathComponent)!
            }
            
            if (error != nil) {
                print(error!)
                _ =  self.delegatee?.perform(self.callBackk, with: "error")
                
            } else {
                //print(httpResponse!)
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    print(json)
                    
                    _ =  self.delegatee?.perform(self.callBackk, with: [json,lastPath] as NSArray)
                    
                } catch {
                    print("json error: \(error)")
                    print("string data \(String(data: data!, encoding: String.Encoding.utf8))")
                    _ =  self.delegatee?.perform(self.callBackk, with: "error")
                }
            }
            
            
            DispatchQueue.main.async {
                //Update your UI here
            }
        }
        dataTask.resume()
    }
    
    
    //MARK:- Service Call with callback
    
//    func callServiceWith(parameterDict:Dictionary<String, String> , url:String,type:String, onCompletion: @escaping (AnyObject)-> Void)
//    {
//        if !Reachability.isConnectedToNetwork()
//        {
//            // _ =  self.delegatee?.perform(self.callBackk, with: "No Internet Connection")
//            onCompletion("No Internet Connection" as AnyObject)
//            return
//        }
//        else
//        {
//            let url = URL(string: WebserviceCall_Swift.server_url + url)!
//            print("REQUEST JSON ",parameterDict,url)
//            var req = URLRequest.init(url: url)
//            req.httpMethod = type.uppercased()
//            req.timeoutInterval = 120
//
//            req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//            req.setValue("application/json", forHTTPHeaderField: "Accept")
//            if type.lowercased() == "post"{
//                req.setBodyContent(parameterDict)
//            }
//
//            let sessionConf = URLSessionConfiguration.default
//            let session = URLSession.init(configuration: sessionConf)
//            let dataTask = session.dataTask(with: req as URLRequest) {data,response,error in
//                let httpResponse = response as? HTTPURLResponse
//                var lastPath = ""
//
//                if httpResponse != nil
//                {
//                    lastPath =  (httpResponse?.url?.lastPathComponent)!
//                }
//
//                if (error != nil)
//                {
//                    print(error!)
//                    //_ =  self.delegatee?.perform(self.callBackk, with: "error")
//                    //print("string data \(String(data: data!, encoding: String.Encoding.utf8) ?? "")")
//
//                    onCompletion("error" as AnyObject)
//
//                }
//                else
//                {
//                    //print(httpResponse!)
//                    do
//                    {
//                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
//                        print("resulted json", json)
//
//                        //                        _ =  self.delegatee?.perform(self.callBackk, with: [json,lastPath] as NSArray)
//                        onCompletion([json,lastPath] as NSArray)
//
//                    }
//                    catch
//                    {
//                        print("string data \(String(data: data!, encoding: String.Encoding.utf8) ?? "")")
//                        print("json error: \(error)")
//                        //                        _ =  self.delegatee?.perform(self.callBackk, with: "error")
//                        onCompletion("error" as AnyObject)
//
//                    }
//                }
//
//
//            }
//
//            dataTask.resume()
//        }
//    }
    
    func callServiceWithDict(parameterDict:NSDictionary,isAuth:Bool = false , url:String,type:String, onCompletion: @escaping (AnyObject)-> Void)
        {
            if !Reachability.isConnectedToNetwork()
            {
                // _ =  self.delegatee?.perform(self.callBackk, with: "No Internet Connection")
                onCompletion("No Internet Connection" as AnyObject)
                return
            }
            else{
                let url = URL(string: WebserviceCall_Swift.server_url + url)!
                print("REQUEST JSON ",parameterDict,url)
                
                
                let session = URLSession.shared
                
                var request = URLRequest(url: url)
                request.httpMethod = type
                if type == "GET"{
                    
                }else
                {
                    if type.lowercased() == "post"
                    {
                        var body = Data()

                        for param in parameterDict
                        {
                            if let data = "--\(boundary)\r\n".data(using: .utf8) {
                                body.append(data)
                            }
                            if let data = "Content-Disposition: form-data; name=\"\(param)\"\r\n\r\n".data(using: .utf8) {
                                body.append(data)
                            }
                            if let object = parameterDict[param], let data = "\(object)\r\n".data(using: .utf8) {
                                body.append(data)
                            }
                        }

                        if let data = "--\(boundary)--\r\n".data(using: .utf8) {
                            body.append(data)
                        }
                        // setting the body of the post to the reqeust
                        request.httpBody = body
                        
                            //request.setBodyContent(parameterDict)
                    }
    //                var  jsonData = NSData()
    //
    //                do {
    //                    jsonData = try JSONSerialization.data(withJSONObject: parameterDict, options: .prettyPrinted) as NSData
    //                    // you can now cast it with the right type
    //                } catch {
    //                    print(error.localizedDescription)
    //                }
                    //request.httpBody = jsonData as Data
    //                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                }
                
                //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

                //request.setValue("*/*", forHTTPHeaderField: "accept")
                if isAuth {
                    request.setValue(Singleton.shared.USERTOKEN, forHTTPHeaderField: "token")
                }
                print("token ========== ",Singleton.shared.USERTOKEN)
                let task = session.dataTask(with: request as URLRequest) {data,response,error in
                    let httpResponse = response as? HTTPURLResponse
                    var lastPath = ""
                    
                    if httpResponse != nil
                    {
                        lastPath =  (httpResponse?.url?.lastPathComponent)!
                    }
                    
                    if (error != nil)
                    {
                        print(error!)
                        //_ =  self.delegatee?.perform(self.callBackk, with: "error")
                        //print("string data \(String(data: data!, encoding: String.Encoding.utf8) ?? "")")
                        
                        onCompletion("error" as AnyObject)
                        
                    }
                    else
                    {
                        //print(httpResponse!)
                        do
                        {
                            let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                            print("resulted json", json)
                            
                            //                        _ =  self.delegatee?.perform(self.callBackk, with: [json,lastPath] as NSArray)
                            onCompletion([json,lastPath] as NSArray)
                            
                        }
                        catch
                        {
                            print("string data \(String(data: data!, encoding: String.Encoding.utf8) ?? "")")
                            print("json error: \(error)")
                            //                        _ =  self.delegatee?.perform(self.callBackk, with: "error")
                            onCompletion("error" as AnyObject)
                            
                        }
                    }
                    
                    
                }
                task.resume()
                
                
            }
        }
    func callServiceWith(parameterDict:Dictionary<String, String>,isAuth:Bool = false , url:String,type:String, onCompletion: @escaping (AnyObject)-> Void)
    {
        if !Reachability.isConnectedToNetwork()
        {
            // _ =  self.delegatee?.perform(self.callBackk, with: "No Internet Connection")
            onCompletion("No Internet Connection" as AnyObject)
            return
        }
        else{
            let url = URL(string: WebserviceCall_Swift.server_url + url)!
            print("REQUEST JSON ",parameterDict,url)
            
            
            let session = URLSession.shared
            
            var request = URLRequest(url: url)
            request.httpMethod = type
            if type == "GET"{
                
            }else
            {
                if type.lowercased() == "post"{
                    request.setBodyContent(parameterDict)
                }
//                var  jsonData = NSData()
//
//                do {
//                    jsonData = try JSONSerialization.data(withJSONObject: parameterDict, options: .prettyPrinted) as NSData
//                    // you can now cast it with the right type
//                } catch {
//                    print(error.localizedDescription)
//                }
                //request.httpBody = jsonData as Data
//                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            }
            
            //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

            //request.setValue("*/*", forHTTPHeaderField: "accept")
            if isAuth {
                request.setValue(Singleton.shared.USERTOKEN, forHTTPHeaderField: "token")
            }
            print("token ========== ",Singleton.shared.USERTOKEN)
            let task = session.dataTask(with: request as URLRequest) {data,response,error in
                let httpResponse = response as? HTTPURLResponse
                var lastPath = ""
                
                if httpResponse != nil
                {
                    lastPath =  (httpResponse?.url?.lastPathComponent)!
                }
                
                if (error != nil)
                {
                    print(error!)
                    //_ =  self.delegatee?.perform(self.callBackk, with: "error")
                    //print("string data \(String(data: data!, encoding: String.Encoding.utf8) ?? "")")
                    
                    onCompletion("error" as AnyObject)
                    
                }
                else
                {
                    //print(httpResponse!)
                    do
                    {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        print("resulted json", json)
                        
                        //                        _ =  self.delegatee?.perform(self.callBackk, with: [json,lastPath] as NSArray)
                        onCompletion([json,lastPath] as NSArray)
                        
                    }
                    catch
                    {
                        print("string data \(String(data: data!, encoding: String.Encoding.utf8) ?? "")")
                        print("json error: \(error)")
                        //                        _ =  self.delegatee?.perform(self.callBackk, with: "error")
                        onCompletion("error" as AnyObject)
                        
                    }
                }
                
                
            }
            task.resume()
            
            
        }
    }
    func callServiceWithFullURL(parameterDict:Dictionary<String, String> ,type:String, url:String , onCompletion: @escaping (AnyObject)-> Void)
    {
        if !Reachability.isConnectedToNetwork(){
            // _ =  self.delegatee?.perform(self.callBackk, with: "No Internet Connection")
            onCompletion("No Internet Connection" as AnyObject)
            return
            
        }else{
            let url = URL(string: url)!
            print("REQUEST JSON ",parameterDict,url)
            var req = URLRequest.init(url: url)
            req.httpMethod = type.uppercased()
            req.timeoutInterval = 120
            
            //req.setValue(postLength, forHTTPHeaderField: "Content-Length")
            req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            req.setValue("application/json", forHTTPHeaderField: "Accept")
            req.setBodyContent(parameterDict)
            
            let sessionConf = URLSessionConfiguration.default
            let session = URLSession.init(configuration: sessionConf)
            let dataTask = session.dataTask(with: req as URLRequest) {data,response,error in
                let httpResponse = response as? HTTPURLResponse
                var lastPath = ""
                
                if httpResponse != nil
                {
                    lastPath =  (httpResponse?.url?.lastPathComponent)!
                }
                
                if (error != nil)
                {
                    print(error!)
                    onCompletion("error" as AnyObject)
                    
                }
                else
                {
                    //print(httpResponse!)
                    do
                    {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        print("resulted json", json)
                        
                        onCompletion([json,lastPath] as NSArray)
                        
                    }
                    catch
                    {
                        print("json error: \(error)")
                        onCompletion("error" as AnyObject)
                        
                    }
                }
                
                DispatchQueue.main.async
                    {
                        //Update your UI here
                }
            }
            
            dataTask.resume()
        }
    }
    
    func callServiceWithMultipleIMageWithMultipleKeys(images:[UIImage],type:String,url:String ,parameterDict:NSMutableDictionary,image_upload_key:String,profile_pic:UIImage?,profile_upload_key:String,isObjectParam:Bool, onCompletion: @escaping (AnyObject)-> Void)
    {
        
        if !Reachability.isConnectedToNetwork()
        {
            // _ =  self.delegatee?.perform(self.callBackk, with: "No Internet Connection")
            onCompletion("No Internet Connection" as AnyObject)
            return
            
        }
        let dictParam = parameterDict
        
        //let url = URL(string: "http://ec2-13-233-28-84.ap-south-1.compute.amazonaws.com/lamah_auth_server/api/farid_test")
        
        let url = URL(string: WebserviceCall_Swift.server_url + url)!
        print("REQUEST JSON ",dictParam,url)
        var req = URLRequest.init(url: url)
        req.httpMethod = type.uppercased()
        req.timeoutInterval = 60
        
        req.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let body = createMultipleBodyForDiffImage11(parameters: dictParam , boundary: boundary, images:images, mimeType: "image/jpg", filename: "",img_key:image_upload_key,isObjectParam:isObjectParam)
        print(body)
        req.httpBody =  body
        
        let postLength = "\(body.count)"
        req.setValue(postLength, forHTTPHeaderField: "Content-Length")
        let sessionConf = URLSessionConfiguration.default
        let session = URLSession.init(configuration: sessionConf)
        let dataTask = session.dataTask(with: req as URLRequest) {data,response,error in
            let httpResponse = response as? HTTPURLResponse
            var lastPath = ""
            if httpResponse != nil{
                lastPath =  (httpResponse?.url?.lastPathComponent)!
            }
            
            if (error != nil) {
                print("json error: \(String.init(data: data!, encoding: .utf8) ?? "")")
                onCompletion("error" as AnyObject)
                
                
            } else {
                //print(httpResponse!)
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    print(json)
                    
                    _ =  self.delegatee?.perform(self.callBackk, with: [json,lastPath] as NSArray)
                    onCompletion([json,lastPath] as NSArray)
                    
                    
                } catch {
                    print("json error: \(String.init(data: data!, encoding: .utf8) ?? "")")
                    onCompletion("error" as AnyObject)
                    
                }
            }
            DispatchQueue.main.async {
                //Update your UI here
            }
        }
        dataTask.resume()
    }
    func createMultipleBodyForDiffImage11(parameters: NSMutableDictionary,
                                          boundary: String,
                                          images:[UIImage],
                                          mimeType: String,
                                          filename: String,img_key:String,isObjectParam:Bool) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        if isObjectParam {
            body.appendString(boundaryPrefix)
            body.append(try! JSONSerialization.data(withJSONObject: parameters, options: []))
            
        }else{
            for (key, value) in parameters {
                body.appendString(boundaryPrefix)
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
            
        }
        //return body as Data
        var i = 0
        for img in images
        {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(img_key)\(i)\"; filename=\"\(img_key)\(i)\"\r\n") // profile_pic is KEY to upload Image
            body.appendString("Content-Type: \(mimeType)\r\n\r\n")
            body.append(img.jpegData(compressionQuality: 0.5)!)
            body.appendString("\r\n")
            
            i = i+1
            print("file name = ","\(img_key)\(i)" )
        }
        body.appendString("--".appending(boundary.appending("--")))
        //body.appendString(boundaryPrefix)
        
        return body as Data
    }
    
    //upload any types of files
    func callServiceWith(fileData:NSData,url:String,type:String,mimeType:String,fileName:String ,parameterDict:Dictionary<String, String>,file_upload_key:String, onCompletion: @escaping (AnyObject)-> Void)
    {
        
        if !Reachability.isConnectedToNetwork()
        {
            // _ =  self.delegatee?.perform(self.callBackk, with: "No Internet Connection")
            onCompletion("No Internet Connection" as AnyObject)
            return
            
        }
        let url = URL(string: WebserviceCall_Swift.server_url + url)!
        print(url)
        var req = URLRequest.init(url: url)
        req.httpMethod = type.uppercased()
        req.timeoutInterval = 60
        
        req.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let body = createBody(parameters: parameterDict, boundary: boundary, data: fileData as Data, mimeType: mimeType, filename: fileName,img_key:file_upload_key)
        print(body)
        req.httpBody =   body
        
        let postLength = "\(body.count)"
        req.setValue(postLength, forHTTPHeaderField: "Content-Length")
        
        req.setValue(Singleton.shared.USERTOKEN, forHTTPHeaderField: "token")

        let sessionConf = URLSessionConfiguration.default
        let session = URLSession.init(configuration: sessionConf)
        let dataTask = session.dataTask(with: req as URLRequest) {data,response,error in
            let httpResponse = response as? HTTPURLResponse
            var lastPath = ""
            if httpResponse != nil{
                lastPath =  (httpResponse?.url?.lastPathComponent)!
            }
            
            if (error != nil) {
                print(error!)
                onCompletion("error" as AnyObject)
                
                
            } else {
                //print(httpResponse!)
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    print(json)
                    
                    _ =  self.delegatee?.perform(self.callBackk, with: [json,lastPath] as NSArray)
                    onCompletion([json,lastPath] as NSArray)
                    
                    
                } catch {
                   print("json error: \(String.init(data: data!, encoding: .utf8) ?? "")")
                    print("json error: \(error)")
                    onCompletion("error" as AnyObject)
                    
                }
            }
            DispatchQueue.main.async {
                //Update your UI here
            }
        }
        dataTask.resume()
    }
    
    func callServiceWith(image:UIImage?,url:String,type:String ,parameterDict:Dictionary<String, String>,image_upload_key:String, onCompletion: @escaping (AnyObject)-> Void)
    {
        
        if !Reachability.isConnectedToNetwork(){
            // _ =  self.delegatee?.perform(self.callBackk, with: "No Internet Connection")
            onCompletion("No Internet Connection" as AnyObject)
            return
            
        }
        let url = URL(string: WebserviceCall_Swift.server_url + url)!
        print(url)
        var req = URLRequest.init(url: url)
        req.httpMethod = type.uppercased()
        req.timeoutInterval = 60
        
        req.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let body = createBody(parameters: parameterDict, boundary: boundary, data: image?.jpegData(compressionQuality: 0.5), mimeType: "image/png",
                              filename: self.getCurrentUnixTime() + ".png",img_key:image_upload_key)
        print(body)
        req.httpBody =   body
        
        let postLength = "\(body.count)"
        req.setValue(postLength, forHTTPHeaderField: "Content-Length")
        
        req.setValue(Singleton.shared.USERTOKEN, forHTTPHeaderField: "token")

        let sessionConf = URLSessionConfiguration.default
        let session = URLSession.init(configuration: sessionConf)
        let dataTask = session.dataTask(with: req as URLRequest) {data,response,error in
            let httpResponse = response as? HTTPURLResponse
            var lastPath = ""
            if httpResponse != nil{
                lastPath =  (httpResponse?.url?.lastPathComponent)!
            }
            
            if (error != nil) {
                print(error!)
                onCompletion("error" as AnyObject)
                
                
            } else {
                //print(httpResponse!)
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    print(json)
                    
                    _ =  self.delegatee?.perform(self.callBackk, with: [json,lastPath] as NSArray)
                    onCompletion([json,lastPath] as NSArray)
                    
                    
                } catch {
                   print("json error: \(String.init(data: data!, encoding: .utf8) ?? "")")
                    print("json error: \(error)")
                    onCompletion("error" as AnyObject)
                    
                }
            }
            DispatchQueue.main.async {
                //Update your UI here
            }
        }
        dataTask.resume()
    }
    
    func callServiceWithMultipleImage(images:[UIImage],type:String,url:String ,parameterDict:Dictionary<String, String>,image_upload_key:String, onCompletion: @escaping (AnyObject)-> Void)
    {
        
        if !Reachability.isConnectedToNetwork(){
            // _ =  self.delegatee?.perform(self.callBackk, with: "No Internet Connection")
            onCompletion("No Internet Connection" as AnyObject)
            return
            
        }
        let url = URL(string: WebserviceCall_Swift.server_url + url)!
        print(url)
        var req = URLRequest.init(url: url)
        req.httpMethod = type.uppercased()
        req.timeoutInterval = 1000
        req.setValue("multipart/form-data; boundary=0xKhTmLbOuNdArY", forHTTPHeaderField: "Content-Type")
        
        let body = createMultipleBody(parameters: parameterDict, boundary: boundary, images:images, mimeType: "image/jpg", filename: "",img_key:image_upload_key, profileImg: nil, profileImgKey: "")
        print(body)
        req.httpBody =   body
        
        let postLength = "\(body.count)"
        req.setValue(postLength, forHTTPHeaderField: "Content-Length")
        let sessionConf = URLSessionConfiguration.default
        let session = URLSession.init(configuration: sessionConf)
        let dataTask = session.dataTask(with: req as URLRequest) {data,response,error in
            let httpResponse = response as? HTTPURLResponse
            var lastPath = ""
            if httpResponse != nil{
                lastPath =  (httpResponse?.url?.lastPathComponent)!
            }
            
            if (error != nil) {
                print(error!)
                if data != nil {
                    print("string data \(String(data: data!, encoding: String.Encoding.utf8) ?? "")")

                }

                onCompletion("error" as AnyObject)
                
            } else {
                //print(httpResponse!)
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    print(json)
                    
                    onCompletion([json,lastPath] as NSArray)
                    
                } catch {
                    
                    print("json error: \(error)")
                    if data != nil {
                                       print("string data \(String(data: data!, encoding: String.Encoding.utf8) ?? "")")

                                   }
                    onCompletion("error" as AnyObject)
                }
            }
            DispatchQueue.main.async {
                //Update your UI here
            }
        }
        dataTask.resume()
    }
    
    func callServiceWithMultipleMediaType(images:[Data],videoData:[Data],url:String ,parameterDict:Dictionary<String, String>,image_upload_key:String,video_upload_key:String, onCompletion: @escaping (AnyObject)-> Void)
    {
        if !Reachability.isConnectedToNetwork(){
            // _ =  self.delegatee?.perform(self.callBackk, with: "No Internet Connection")
            onCompletion("No Internet Connection" as AnyObject)
            return
            
        }
        let url = URL(string: WebserviceCall_Swift.server_url + url)!
        print(url)
        var req = URLRequest.init(url: url)
        req.httpMethod = "POST"
        req.timeoutInterval = 1000
        req.setValue("multipart/form-data; boundary=0xKhTmLbOuNdArY", forHTTPHeaderField: "Content-Type")
        
        //let body = createMultipleBody(parameters: parameterDict, boundary: boundary, images:images, mimeType: "image/jpg",img_key:image_upload_key)
        let body = createMultipleBodyWithMedia(parameters: parameterDict, boundary: boundary, images: images, videoData: videoData, img_key: image_upload_key, video_key: video_upload_key)
        print(body)
        req.httpBody =   body
        
        let postLength = "\(body.count)"
        req.setValue(postLength, forHTTPHeaderField: "Content-Length")
        let sessionConf = URLSessionConfiguration.default
        let session = URLSession.init(configuration: sessionConf)
        let dataTask = session.dataTask(with: req as URLRequest) {data,response,error in
            let httpResponse = response as? HTTPURLResponse
            var lastPath = ""
            if httpResponse != nil{
                lastPath =  (httpResponse?.url?.lastPathComponent)!
            }
            
            if (error != nil) {
                print(error!)
                onCompletion("error" as AnyObject)
                
            } else {
                //print(httpResponse!)
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    print(json)
                    
                    onCompletion([json,lastPath] as NSArray)
                    
                    
                } catch {
                    print("json error: \(error)")
                    onCompletion("error" as AnyObject)
                }
            }
            DispatchQueue.main.async {
                //Update your UI here
            }
        }
        dataTask.resume()
    }
    
    //MARK:- Support Method
    
    func createMultipleBody(parameters: [String: String],
                    boundary: String,
                    images:[UIImage],
                    mimeType: String,
                    filename: String,img_key:String,profileImg:UIImage?,profileImgKey:String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--0xKhTmLbOuNdArY\r\n"
        let boundry = "0xKhTmLbOuNdArY"

        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        var i = 0
        for img in images {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(img_key)[]\"; filename=\"\(img_key)\(i).jpg\"\r\n") // name =  is KEY to upload Image
 
            body.appendString("Content-Type: image/jpeg\r\n\r\n")
            body.append(img.jpegData(compressionQuality: 0.5)!)

            body.appendString("\r\n")
            i = i+1
        }
        body.appendString("--0xKhTmLbOuNdArY--\r\n")
        
        
        if profileImg != nil {
            body.appendString(boundaryPrefix)
                    body.appendString("Content-Disposition: form-data; name=\"\(profileImgKey)\"; filename=\"profile_pic.jpg\"\r\n") // profile_pic is KEY to upload Image
            //  [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", @"images[]",[NSString stringWithFormat:@"%d%@",i,img_name]]
            body.appendString("Content-Type: image/jpeg\r\n\r\n")
            body.append(profileImg!.jpegData(compressionQuality: 0.5)!)

            body.appendString("\r\n")
        }
        body.appendString("--0xKhTmLbOuNdArY--\r\n")

        return body as Data
    }
    
    func createMultipleBodyWithMedia(parameters: [String: String],
                                     boundary: String,
                                     images:[Data],videoData:[Data],
                                     img_key:String,video_key:String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--0xKhTmLbOuNdArY\r\n"
        
        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        var i = 0
        for img in images {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"file_path\"; filename=\"\(img_key)\(i).jpg\"\r\n") // profile_pic is KEY to upload Image
            //  [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", @"images[]",[NSString stringWithFormat:@"%d%@",i,img_name]]
            body.appendString("Content-Type: image/jpeg\r\n\r\n")
            body.append(img)
            
            body.appendString("\r\n")
            i = i+1
        }
        body.appendString("--0xKhTmLbOuNdArY--\r\n")
        
        var j = 0
        for vid in videoData {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"file_path\"; filename=\"\(video_key)\(j).mp4\"\r\n") // profile_pic is KEY to upload Image
            //  [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", @"images[]",[NSString stringWithFormat:@"%d%@",i,img_name]]
            body.appendString("Content-Type: video/mp4\r\n\r\n")
            body.append(vid)
            
            body.appendString("\r\n")
            j = j+1
        }
        body.appendString("--0xKhTmLbOuNdArY--\r\n")
        
        return body as Data
    }
    
    func createBody(parameters: [String: String],
                    boundary: String,
                    data: Data?,
                    mimeType: String,
                    filename: String,img_key:String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        if data != nil {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(img_key)\"; filename=\"\(filename)\"\r\n") // profile_pic is KEY to upload Image
            body.appendString("Content-Type: \(mimeType)\r\n\r\n")
            body.append(data!)
            body.appendString("\r\n")
            body.appendString("--".appending(boundary.appending("--")))
        }
        
        
        return body as Data
    }
    
    func uploadImages(request: NSURLRequest, images: [UIImage] , image_upload_key:String) {
        
        let uuid = NSUUID().uuidString
        let boundary = String.init(repeating: "-" as Character, count: 24)+uuid
        
        // Open the file
        let directoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        
        let fileURL = directoryURL.appendingPathComponent(uuid)
        let filePath = fileURL.path
        
        FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil)
        
        let file = FileHandle(forWritingAtPath: filePath)!
        
        
        // Write each image to a MIME part.
        let newline = "\r\n"
        
        for (i, image) in images.enumerated() {
            
            let partName = image_upload_key
            let partFilename = "\(partName).png"
            let partMimeType = "image/jpg"
            let partData = image.jpegData(compressionQuality: 0.5)
            
            // Write boundary header
            var header = ""
            header += "--\(boundary)" + newline
            header += "Content-Disposition: form-data; name=\"\(partName)\"; filename=\"\(partFilename)\"" + newline
            header += "Content-Type: \(partMimeType)" + newline
            header += newline
            
            let headerData = header.data(using: String.Encoding.utf8, allowLossyConversion: false)
            
            print("")
            print("Writing header #\(i)")
            print(header)
            
            print("Writing data")
            print("\(partData!.count) Bytes")
            
            // Write data
            file.write(headerData!)
            file.write(partData!)
        }
        
        // Write boundary footer
        var footer = ""
        footer += newline
        footer += "--\(boundary)--" + newline
        footer += newline
        
        print("")
        print("Writing footer")
        print(footer)
        
        let footerData = footer.data(using: String.Encoding.utf8, allowLossyConversion: false)
        file.write(footerData!)
        
        file.closeFile()
        
        // Add the content type for the request to multipart.
        let outputRequest = request.copy() as! NSMutableURLRequest
        
        let contentType = "multipart/form-data; boundary=\(boundary)"
        outputRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        do
        {
            let tempData = try NSData.init(contentsOf: fileURL)
            upload(request: outputRequest as URLRequest, data: tempData!)
            
        }catch {
            print ("")
        }
        // Start uploading files.
       
    }
    
    
    func upload(request: URLRequest, data: NSData)
    {
        // Create a unique identifier for the session.
        let sessionIdentifier = NSUUID().uuidString
        
        let directoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileURL = directoryURL.appendingPathComponent(sessionIdentifier)
        
        // Write data to cache file.
        data.write(to: fileURL, atomically: true)
        

        
        
        var req = request
        req.httpBody = data as Data
        req.setValue("\((data as Data).count)", forHTTPHeaderField: "Content-Length")

        // Store the session, so that we don't recreate it if app resumes from suspend.
        //session[sessionIdentifier] = session
       
        let sessionConf = URLSessionConfiguration.default
        let sessionService = URLSession.init(configuration: sessionConf)
        let dataTask = sessionService.dataTask(with: req as URLRequest) {data,response,error in
            let httpResponse = response as? HTTPURLResponse
            var lastPath = ""
            if httpResponse != nil{
                lastPath =  (httpResponse?.url?.lastPathComponent)!
            }
            
            if (error != nil) {
                print(error!)
                _ =  self.delegatee?.perform(self.callBackk, with: "error")
                
            } else {
                //print(httpResponse!)
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    print(json)
                    
                    _ =  self.delegatee?.perform(self.callBackk, with: [json,lastPath] as NSArray)
                    
                } catch {
                    print("json error: \(error)")
                    _ =  self.delegatee?.perform(self.callBackk, with: "error")
                }
            }
            DispatchQueue.main.async {
                //Update your UI here
            }
        }
        
        dataTask.resume()
    }
    
    
    func generateBoundaryString() -> String {
        return "0xKhTmLbOuNdArY"//"Boundary-\(NSUUID().uuidString)"
    }
    
    func getCurrentUnixTime() -> String {
        let unixTime = String.init(format: "%f", NSDate().timeIntervalSince1970)
        let splitArray = unixTime.components(separatedBy: ".")
        //print("Current unix timestamp \(splitArray[0])")
        return splitArray[0]
    }
    
    //MARK:- Google Service Calling
    
    func googleServiceCalling(with geoID:String , isState:String) {
        let url = URL(string: "http://api.geonames.org/childrenJSON?geonameId=\(geoID)&username=webvilleedeveloper")!
        print(url)
        var req = URLRequest.init(url: url)
        req.httpMethod = "POST"
        req.timeoutInterval = 60
        
        //req.setValue(postLength, forHTTPHeaderField: "Content-Length")
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let sessionConf = URLSessionConfiguration.default
        let sessionService = URLSession.init(configuration: sessionConf)
        let dataTask = sessionService.dataTask(with: req as URLRequest) {data,response,error in
            let httpResponse = response as? HTTPURLResponse
            var lastPath = ""
            
            if httpResponse != nil
            {
                lastPath =  (httpResponse?.url?.lastPathComponent)!
            }
            
            if (error != nil)
            {
                print(error!)
                _ =  self.delegatee?.perform(self.callBackk, with: "error")
                
            }
            else
            {
                //print(httpResponse!)
                do
                {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    print("resulted json", json)
                    
                    _ =  self.delegatee?.perform(self.callBackk, with: [json,lastPath,isState] as NSArray)
                }
                catch
                {
                    print("json error: \(error)")
                    _ =  self.delegatee?.perform(self.callBackk, with: "error")
                }
            }
            
            DispatchQueue.main.async
                {
                    //Update your UI here
            }
        }
        
        dataTask.resume()
    }
    func getCountry(){
        
        let url = URL(string: "http://api.geonames.org/countryInfoJSON?username=webvilleedeveloper")
        var req = URLRequest.init(url: url!)
        req.httpMethod = "POST"
        req.timeoutInterval = 60
        
        //req.setValue(postLength, forHTTPHeaderField: "Content-Length")
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let sessionConf = URLSessionConfiguration.default
        let sessionService = URLSession.init(configuration: sessionConf)
        let dataTask = sessionService.dataTask(with: req as URLRequest) {data,response,error in
            let httpResponse = response as? HTTPURLResponse
            var lastPath = ""
            
            if httpResponse != nil
            {
                lastPath =  (httpResponse?.url?.lastPathComponent)!
            }
            
            if (error != nil)
            {
                print(error!)
                _ =  self.delegatee?.perform(self.callBackk, with: "error")
                
            }
            else
            {
                //print(httpResponse!)
                do
                {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    print("resulted json", json)
                    
                    _ =  self.delegatee?.perform(self.callBackk, with: [json,lastPath] as NSArray)
                }
                catch
                {
                    print("json error: \(error)")
                    _ =  self.delegatee?.perform(self.callBackk, with: "error")
                }
            }
            
            DispatchQueue.main.async
                {
                    //Update your UI here
            }
        }
        
        dataTask.resume()
        
    }
    
    func googleAPICall(placeName:String) {
        var components = URLComponents(string: "https://maps.googleapis.com/maps/api/geocode/json")!
        let key = URLQueryItem(name: "key", value: KEY_GOOGLE) // use your key
        let address = URLQueryItem(name: "address", value: placeName)
        components.queryItems = [key, address]
        
        let task = URLSession.shared.dataTask(with: components.url!) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, error == nil else {
                //                print(String(describing: response))
                //                print(String(describing: error))
                return
            }
            
            guard let json = try! JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                //                print("not JSON format expected")
                //                print(String(data: data, encoding: .utf8) ?? "Not string?!?")
                return
            }
            
            guard let results = json["results"] as? [[String: Any]],
                let status = json["status"] as? String,
                status == "OK" else {
                    print("no results")
                    print(String(describing: json))
                    return
            }
            
            DispatchQueue.main.async {
                // now do something with the results, e.g. grab `formatted_address`:
                
                
                let arrResult = results as NSArray
                let resultDict = arrResult.object(at: 0) as! NSDictionary
                if resultDict.object(forKey: "geometry") != nil {
                let geoDict = resultDict.object(forKey: "geometry") as! NSDictionary
                    if geoDict.object(forKey: "location") != nil {
                    let boundDict = geoDict.object(forKey: "location") as! NSDictionary
                        if boundDict.count > 0 {
                                        _ =  self.delegatee?.perform(self.callBackk, with: [boundDict,"geolocation"] as NSArray)
                    }
                }
                    
                }

                
            }
        }
        
        task.resume()
        
    }
    
    //http://ec2-34-236-197-140.compute-1.amazonaws.com:3024/rur_privacy_policy.json
    
    
    
    //MARK: Delegate
    
    
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
    
        let httpResponse = response as? HTTPURLResponse
        var lastPath = ""
        
        if httpResponse != nil
        {
            lastPath =  (httpResponse?.url?.lastPathComponent)!
        }
        
//        if (error != nil)
//        {
            print(lastPath)
//            _ =  self.delegatee?.perform(self.callBackk, with: "error")
//
//        }
//        else
//        {
//            //print(httpResponse!)
//            do
//            {
//                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
//                print("resulted json", json)
//
//                _ =  self.delegatee?.perform(self.callBackk, with: [json,lastPath] as NSArray)
//            }
//            catch
//            {
//                print("json error: \(error)")
//                _ =  self.delegatee?.perform(self.callBackk, with: "error")
//            }
//        }
    }
    
    class func getAllCity(){
        let params = ["":""] as Dictionary<String, String>
        
        var request = URLRequest(url: URL(string: "http://ec2-34-236-197-140.compute-1.amazonaws.com:3024/api/users/getallcities")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //print("http://ec2-34-236-197-140.compute-1.amazonaws.com:3024/api/users/getallcities")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            //print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!)
               
                //print("Json response",json)
               
            } catch {
                //print("error")
            }
        })
        
        task.resume()
    }

}






