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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
        
    
    
      
    

    
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


}

