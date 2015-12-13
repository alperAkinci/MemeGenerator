//
//  MemeTableViewController.swift
//  MemeGenerator
//
//  Created by Alper on 13/12/15.
//  Copyright © 2015 Alper. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController : UIViewController ,UITableViewDelegate ,UITableViewDataSource  {
    
    var memes :[Meme]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        memes = applicationDelegate.memes
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.memes.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell")
        
        let meme = self.memes[indexPath.row]
        
        cell?.textLabel?.text = "\(meme.topText) \(meme.bottomText)"
        cell?.imageView?.image = meme.memedImage
        
        return cell!
        
    }
    
    
}