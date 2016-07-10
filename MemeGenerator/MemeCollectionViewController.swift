//
//  MemeCollectionViewController.swift
//  MemeGenerator
//
//  Created by Alper on 13/12/15.
//  Copyright © 2015 Alper. All rights reserved.
//

import Foundation

import UIKit


class MemeCollectionViewController : UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    //MARK:Properties
    var memes :[Meme]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        memes = applicationDelegate.memes
        
        flowLayoutSettings()
    }
    
    
    
    //MARK: Data Source Methods
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        
        let meme = self.memes[indexPath.row]
        
        cell.memeImageView.image = meme.memedImage
        
        return cell
        
    }
    
    //MARK:Layout Stuff
    func flowLayoutSettings() {
        
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    
    
    }
    
    
    
}