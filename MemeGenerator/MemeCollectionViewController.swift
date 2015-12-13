//
//  MemeCollectionViewController.swift
//  MemeGenerator
//
//  Created by Alper on 13/12/15.
//  Copyright © 2015 Alper. All rights reserved.
//

import Foundation

import UIKit


class MemeCollectionViewController : UIViewController ,UICollectionViewDataSource {
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        
        let meme = self.memes[indexPath.row]
        
        cell.memeImageView.image = meme.memedImage
        
        return cell
        
    }
    
    
    
}