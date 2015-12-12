//
//  ViewController.swift
//  MemeGenerator
//
//  Created by Alper on 09/12/15.
//  Copyright © 2015 Alper. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imagePickerView: UIImageView!
   
    @IBOutlet weak var cameraButton: UIBarButtonItem!
   
    @IBOutlet weak var topTextfield: UITextField!
    
    @IBOutlet weak var bottomTextfield: UITextField!
   
   
    // Textfield Delegate Objects
    
    var toptextfield = TextfieldDelegate()
    var bottomtextfield = TextfieldDelegate()

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        topTextfield.delegate = toptextfield
        bottomTextfield.delegate = bottomtextfield
        
       
           }
    
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications()
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    

    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    
    
    //MARK:Image Picking Stuff

    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        
        let pickerController = UIImagePickerController()
       
        pickerController.delegate = self
    
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
   
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        
        let pickerController = UIImagePickerController()
        
        pickerController.delegate = self
        
        pickerController.sourceType = UIImagePickerControllerSourceType.Camera
        
        self.presentViewController(pickerController, animated: true, completion: nil)
    }

    
    //get access to an image chosen from the Photo library or camera
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        
        imagePickerView.image = image
        
        //imagePickerView.contentMode = UIViewContentMode.ScaleToFill
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
   //MARK:NSNotification stuff
    
   //Sign up to be notified when the keyboard appears
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:"    , name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:"    , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    //Sign up to be notified when the keyboard disappears
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)

    }
    
   //When the keyboardWillShow notification is received, shift the view's frame up
    func keyboardWillShow(notification: NSNotification) {
        view.frame.origin.y -= getKeyboardHeight(notification)/2
    }
    
    //When the keyboardWillHide notification is received, shift the view's frame down
    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y += getKeyboardHeight(notification)/2
    }
    
    
    // Problem : it takes double size of keyboard thats why
    // i divide by 2 in upper functions
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // TODO:  Show toolbar and navbar
        
        return memedImage
    }
    
    func save() {
        let memedImage = generateMemedImage()
        //Create the meme
        let meme = Meme(topText: topTextfield.text!,bottomText: bottomTextfield.text!,
            originalImage: imagePickerView.image!, memedImage: memedImage)
    }
    

}

