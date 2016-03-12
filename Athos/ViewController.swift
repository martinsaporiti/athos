//
//  ViewController.swift
//  Athos
//
//  Created by Martin Saporiti on 12/3/16.
//  Copyright © 2016 FluxIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
                        UINavigationControllerDelegate {

    
    var filteredImage : UIImage?
    var originalImage : UIImage?
    var isShowingOriginal : Bool = true
    var extent: CGRect!
    var scaleFactor: CGFloat!
    let context = CIContext(options: nil)
    
    
    // Variables para elementos gráficos.
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var bottomMenu: UIView!
    @IBOutlet var filterMenu: UIView!
    @IBOutlet var filterButton: UIButton!
    
    // -------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterMenu.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        filterMenu.tintColor = UIColor.whiteColor()
        filterMenu.translatesAutoresizingMaskIntoConstraints = false
        scaleFactor = UIScreen.mainScreen().scale
        originalImage = imageView.image
        filteredImage =  imageView.image
        isShowingOriginal = true
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onNewPhotoToggle(sender: UIButton) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default,
            handler: {action in
                self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default,
            handler: {action in
                self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel,
            handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)

    }

    
    // Acción que prende la cámara.
    func showCamera(){
        hideSecondaryMenu()
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        presentViewController(cameraPicker, animated: true, completion: nil)
        
    }
    
    
    // Acción que muestra la librería de fotos.
    func showAlbum(){
        hideSecondaryMenu()
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            originalImage = image
            filteredImage = image
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    /**

    */
    @IBAction func onFilterToggle(sender: UIButton) {
        if(sender.selected){
            hideSecondaryMenu()
            sender.selected = false
        }else{
            showSecondaryMenu()
            sender.selected = true
        }
    }
    
    
    // Show the filter menu
    func showSecondaryMenu(){
        // Add de submenu
        view.addSubview(filterMenu)
        
        // Define constraints
        let bottomConstraint = filterMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = filterMenu.leftAnchor.constraintEqualToAnchor(bottomMenu.leftAnchor)
        let rightConstraint = filterMenu.rightAnchor.constraintEqualToAnchor(bottomMenu.rightAnchor)
        let heightConstraint = filterMenu.heightAnchor.constraintEqualToConstant(44)
        
        // Activate the constraints.
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        view.layoutIfNeeded()
        
        self.filterMenu.alpha = 0
        UIView.animateWithDuration(0.4){
            self.filterMenu.alpha = 1
        }
    }
    
    // Hide the Filter Menu.
    func hideSecondaryMenu(){
        filterButton.selected = false
        UIView.animateWithDuration(0.4, animations: {
            self.filterMenu.alpha = 0
            }){ completed in
                // Resuelve el problema del doble click rápido.
                if(completed){
                    self.filterMenu.removeFromSuperview()
                }
        }
    }
    
    @IBAction func onCompareToggle(sender: UIButton) {
        if (isShowingOriginal){
            imageView.image = filteredImage
            isShowingOriginal = false
        } else {
            imageView.image = originalImage
            isShowingOriginal = true
        }
    }
    
    @IBAction func onShareToggle(sender: UIButton) {
        let activityController = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    
    @IBAction func onEarthToggle(sender: UIButton) {
        let filter = Filter()
        filteredImage = filter.applyEarthFilter(originalImage!)
        imageView.image = filteredImage
        isShowingOriginal = false
    }
    
    @IBAction func onFireToggle(sender: UIButton) {
        let filter = Filter()
        filteredImage = filter.applyFireFilter(originalImage!)
        imageView.image = filteredImage
        isShowingOriginal = false
    }
    
    @IBAction func onWaterToggle(sender: UIButton) {
        let filter = Filter()
        filteredImage = filter.applyWaterFilter(originalImage!)
        imageView.image = filteredImage
        isShowingOriginal = false
    }
    
    @IBAction func onAirToggle(sender: UIButton) {
        let filter = Filter()
        filteredImage = filter.applyAirFilter(originalImage!)
        imageView.image = filteredImage
        isShowingOriginal = false
    }
    
}

