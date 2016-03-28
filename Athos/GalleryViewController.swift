//
//  GalleryCollectionViewController.swift
//  Athos
//
//  Created by Martin Saporiti on 23/3/16.
//  Copyright © 2016 FluxIT. All rights reserved.
//

import UIKit
import Photos


class GalleryCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
 
    @IBOutlet weak var collectionView: UICollectionView!
    
    let reuseIdentifier = "Cell"
    
    // Objeto PHFetchResult para el datasource
    var photosAssets = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadPhotos()

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /**

    */
    func loadPhotos(){
        
        
        let albumes = PHAsset.fetchAssetsWithMediaType(.Image, options: nil)
        albumes.enumerateObjectsUsingBlock {
            object, index, stop in
            let asset = object as! PHAsset
            self.photosAssets.append(asset)
        }
        
        //let album : PHAssetCollection = albumes.firstObject as! PHAssetCollection
        
        //PHAsset.fetchAssetsWithMediaType(.Image, options: nil)

        //let album:PHAssetCollection = PHAsset.fetchAssetsWithMediaType(.Image, options: nil)
        // Cargamos los assets del album
        //let results = PHAsset.fetchAssetsInAssetCollection(albumes, options: nil)
            
        //elements = results
        // photoAsset is an object of type PHFetchResult
        
        // let fetchResult = PHAssetCollection.fetchAssetCollectionsWithType(
        //    PHAssetCollectionType.Moment,
        //    subtype: PHAssetCollectionSubtype.Any,
        //    options: nil)
        

        
        //let album : PHAssetCollection = albumes.lastObject as! PHAssetCollection
        //let assets = PHAsset.fetchAssetsInAssetCollection(album, options: nil)
        //elements = assets
        
        //let fetchResult = PHAssetCollection.fetchAssetCollectionsWithType(
        //    PHAssetCollectionType.Moment,
        //    subtype: PHAssetCollectionSubtype.Any,
        //    options: nil)
        
        //fetchResult.enumerateObjectsUsingBlock { (photo, index, stop) in
        //    let photoAsset = photo as! PHAsset
        //    let photo = PHAsset.fetchAssetsInAssetCollection(photoAsset, options: nil)
        //    self.photos.append(photo)
        //}
        
    }
    
 
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Cantidad de imágenes a mostrar: ", self.photosAssets.count)
        return self.photosAssets.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //UICollectionViewDelegateFlowLayout methods
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 5
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 5
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! GalleryPhotoCell
        cell.backgroundColor = UIColor.blackColor()
        let asset = self.photosAssets[indexPath.row]
        let options = PHImageRequestOptions()
        
        options.resizeMode = PHImageRequestOptionsResizeMode.Exact
        options.deliveryMode = PHImageRequestOptionsDeliveryMode.Opportunistic
        let scaleFactor = UIScreen.mainScreen().scale
        
        
        let cropSideLength = CGFloat(min(asset.pixelWidth, asset.pixelHeight))
        let square = CGRect(x: 0, y: 0, width: cropSideLength, height: cropSideLength)
        
        options.normalizedCropRect = CGRectApplyAffineTransform(square, CGAffineTransformMakeScale(1.0 / CGFloat(asset.pixelWidth), 1.0 / CGFloat(asset.pixelHeight)))
        
        options.synchronous = false
        
        let targetSize = CGSize(width: 115 * scaleFactor, height: 115 * scaleFactor)
        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: targetSize, contentMode: PHImageContentMode.AspectFit, options: options, resultHandler: { (result, info) -> Void in
            cell.imageView.image = result
        })
        return cell
    }
 
    
    //MARK: Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        let photoEditorViewController = segue.destinationViewController as! PhotoEditorViewController
        
        // Get the cell that generated this segue.
        if let selectedPhotoCell = sender as? GalleryPhotoCell {
            let indexPath = collectionView.indexPathForCell(selectedPhotoCell)!
            //let selectedPhoto = images[indexPath.row]
            //photoEditorViewController.originalImage = selectedPhoto

            
            let asset = self.photosAssets[indexPath.row]
            let options = PHImageRequestOptions()
            options.resizeMode = PHImageRequestOptionsResizeMode.Exact
            options.deliveryMode = PHImageRequestOptionsDeliveryMode.HighQualityFormat
            options.synchronous = true
            let imageSize = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
            PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: imageSize, contentMode: PHImageContentMode.AspectFill, options: options, resultHandler: { (result, info) -> Void in
                print(result)
                photoEditorViewController.originalImage = result
            })
        }
    }
    
}
