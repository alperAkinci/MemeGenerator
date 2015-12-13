//
//  ViewController.swift
//  MemeGenerator
//
//  Created by Alper on 09/12/15.
//  Copyright © 2015 Alper. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imagePickerView: UIImageView!
   
    @IBOutlet weak var cameraButton: UIBarButtonItem!
   
    @IBOutlet weak var topTextfield: UITextField!
    
    @IBOutlet weak var bottomTextfield: UITextField!
   
    @IBOutlet weak var shareButton: UIBarButtonItem!
   
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
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
        
        
        //share button enabled/disabled
        shareButton.enabled = (imagePickerView.image == nil) ? false : true
        
        

    }
    

    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    // Hides battery , clock and carrier icons at the top
    override func prefersStatusBarHidden() -> Bool {
        return true;
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

    
    //MARK:UIImagePickerControllerDelegate
    
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
        if bottomTextfield.isFirstResponder(){
        view.frame.origin.y -= getKeyboardHeight(notification)
        }
        }
    
    //When the keyboardWillHide notification is received, shift the view's frame down
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextfield.isFirstResponder(){
        view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    
    //MARK: Share Button Pressed
    
    @IBAction func shareButtonPressed(sender: AnyObject) {
        
        let memedImage = generateMemedImage()
        //let string = "Alper"
        let nextController = UIActivityViewController(activityItems: [memedImage] , applicationActivities: nil )
        
        
      nextController.completionWithItemsHandler = {(s: String?, ok: Bool, items: [AnyObject]?, err:NSError?) -> Void in
            self.save()
            //self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        self.presentViewController(nextController, animated: true, completion: nil)
    }

    
    
    func generateMemedImage() -> UIImage {
        
        // Hide toolbar and navbar
        self.topToolbar.hidden = true
        self.bottomToolbar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        self.topToolbar.hidden = false
        self.bottomToolbar.hidden = false
        
        return memedImage
    }
    
    func save() {
        let memedImage = generateMemedImage()
        //Create the meme
        let meme = Meme(topText: topTextfield.text!,bottomText: bottomTextfield.text!,
            originalImage: imagePickerView.image!, memedImage: memedImage)
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    

}

