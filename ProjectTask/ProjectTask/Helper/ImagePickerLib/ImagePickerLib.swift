//
//  ImagePickerLib.swift
//  BookieBot
//
//  Created by apple on 19/08/20.
//  Copyright © 2020 Mac-4. All rights reserved.
//

import UIKit
import MobileCoreServices


class ImagePickerLib: NSObject, UIImagePickerControllerDelegate & UINavigationControllerDelegate,UIDocumentPickerDelegate, UIDocumentInteractionControllerDelegate
{
    static let shared  = ImagePickerLib()
    
    let documentInteractionController = UIDocumentInteractionController()
    var dataDoc = Data()
    var media_type = ""
    
    var onResult : ((UIImage?,Data?,String?,String?)-> Void)!
    var controller = UIViewController()
    
    //MARK:get image from camera & photo library
    func showImagePicker(viewController:UIViewController,file:Bool, onCompletion: @escaping (UIImage?,Data?,String?,String?)-> Void)
    {
        self.onResult = onCompletion
        controller = viewController
        self.openGallery(file: file)
    }
    
     //    MARK:Image picker
    func openGallery(file:Bool)
        {
            let actionSheetControllerIOS8: UIAlertController = UIAlertController(title:"Select an option", message:"", preferredStyle: .actionSheet)
            
            let cancelActionButton: UIAlertAction = UIAlertAction(title:  "Cancel", style: .cancel) { action -> Void in
            }
            actionSheetControllerIOS8.addAction(cancelActionButton)
            
            let captureActionButton: UIAlertAction = UIAlertAction(title: "Capture Image", style: .default)
            { action -> Void in
                if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerController.CameraDevice.front) {
                    let imagePicker = UIImagePickerController()

                    imagePicker.delegate = self
                    imagePicker.sourceType = UIImagePickerController.SourceType.camera
                    self.controller.navigationController?.present(imagePicker, animated: true, completion: {
                    })
                    
                }
                else{
                    let alert = UIAlertController(title: "No Camera", message: "Camera not available in your device", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
                    self.controller.navigationController?.pushViewController(alert, animated: true)
                    
                }
                
            }
            actionSheetControllerIOS8.addAction(captureActionButton)
            
            let importActionButton: UIAlertAction = UIAlertAction(title: "Import From Gallery", style: .default)
            { action -> Void in
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
                    //self.selectImageFlag = true
                    let imagePicker = UIImagePickerController()

                    imagePicker.delegate = self
                    imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                    self.controller.navigationController?.present(imagePicker, animated: true, completion: {
                    })
                    
                }
                else{
                    let alert = UIAlertController(title: "No Gallery", message: "Gallery not available in your device", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
                    self.controller.present(alert, animated: true, completion: nil)
                    
                }
                
            }
            actionSheetControllerIOS8.addAction(importActionButton)
            
            if file
            {
                let importActionButtonDoc: UIAlertAction = UIAlertAction(title: "Import From File", style: .default)
                           { action -> Void in
                               
                               let documentPicker = UIDocumentPickerViewController(documentTypes: ["com.microsoft.word.doc","org.openxmlformats.wordprocessingml.document", kUTTypePDF as String, kUTTypeImage as String], in: .import)
                                           documentPicker.delegate = self
                                           if #available(iOS 11.0, *) {
                                               documentPicker.allowsMultipleSelection = false
                                           } else {
                                           }
                               self.controller.navigationController?.present(documentPicker, animated: true, completion: {
                               })
                               
                           }
                           actionSheetControllerIOS8.addAction(importActionButtonDoc)
            }
            controller.present(actionSheetControllerIOS8, animated: true, completion: nil)
    }
    
    
    
    //MARK:- documentPicker delegate
           func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
            
               do {
                   let data = try Data(contentsOf: url)
                let fileSize: Int = data.count
                print("actual size of image in MB: %f ", Double(fileSize) / 1000000.0)
                let size =  Double(fileSize) / 1000000.0
                //"File size is \(size)".printOn()
                if size >= 20.00
                {
                    Singleton.actionShowMessage(message: "File upload size limit exceeded. File size should not be bigger than 20mb")
                    return
                }
                else
                {
                   self.dataDoc = data
                   self.onResult(nil,self.dataDoc,url.lastPathComponent,"file/pdf")
                }
               } catch {
                   print(error.localizedDescription)
               }
               self.media_type = "file"
         
              
           }
        // MARK: ImagePicker Delgate
           func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
               //selectImageFlag = false
               controller.navigationController?.dismiss(animated: true, completion: nil)
           }
           
           
           func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
           {
               controller.navigationController?.dismiss(animated: true, completion: {
                   let image = info[.originalImage] as? UIImage
                
                self.onResult(image!,(image?.jpegData(compressionQuality: 0.1))!,Singleton.shared.getCurrentUnixTime()+".png","image/png")

               })
           }


}
