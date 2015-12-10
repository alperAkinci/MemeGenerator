//
//  TextfieldDelegate.swift
//  MemeGenerator
//
//  Created by Alper on 10/12/15.
//  Copyright © 2015 Alper. All rights reserved.
//

import Foundation
import UIKit
class  TextfieldDelegate: NSObject ,UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
}