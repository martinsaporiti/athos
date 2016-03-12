//
//  Filter.swift
//  Athos
//
//  Created by Martin Saporiti on 12/3/16.
//  Copyright © 2016 FluxIT. All rights reserved.
//

import Foundation
import UIKit

class Filter {
    
    let context = CIContext(options: nil)
    
    
    func applyEarthFilter(image: UIImage) -> UIImage {
        
        let inputImage = CIImage(image:image)
        
        let filter = CIFilter(name:"CIColorClamp")
        filter!.setValue(inputImage, forKey: kCIInputImageKey)
        
        let lowerLevel = CIVector(x: 0.1, y: 0.1, z: 0.3, w: 0)
        filter!.setValue(lowerLevel, forKey: "inputMinComponents")
        let upperLevel = CIVector(x: 0.5, y: 0.7, z: 0.9, w: 1)
        filter!.setValue(upperLevel, forKey: "inputMaxComponents")
        
        return UIImage(CGImage: context.createCGImage(filter!.outputImage!,
            fromRect: filter!.outputImage!.extent), scale: image.scale, orientation: image.imageOrientation)

    }
    
    
    func applyFireFilter(image: UIImage)->UIImage{
        let inputImage = CIImage(image:image)
        
        let filter = CIFilter(name:"CIPhotoEffectFade")
        filter!.setValue(inputImage, forKey: kCIInputImageKey)
        
        return UIImage(CGImage: context.createCGImage(filter!.outputImage!,
            fromRect: filter!.outputImage!.extent), scale: image.scale, orientation: image.imageOrientation)
    }
    
    func applyWaterFilter(image: UIImage) -> UIImage {
        
        let inputImage = CIImage(image:image)
        
        let filter = CIFilter(name:"CIPhotoEffectProcess")
        filter!.setValue(inputImage, forKey: kCIInputImageKey)
        
        return UIImage(CGImage: context.createCGImage(filter!.outputImage!,
            fromRect: filter!.outputImage!.extent), scale: image.scale, orientation: image.imageOrientation)
    }
    
    
    func applyAirFilter(image: UIImage) -> UIImage {
        let inputImage = CIImage(image:image)
        
        let filter = CIFilter(name:"CIPhotoEffectMono")
        filter!.setValue(inputImage, forKey: kCIInputImageKey)
        
       return UIImage(CGImage: context.createCGImage(filter!.outputImage!,
            fromRect: filter!.outputImage!.extent), scale: image.scale, orientation: image.imageOrientation)
    }
    
    
    func applyVignette(image: UIImage) -> UIImage {
        let inputImage = CIImage(image: image)
        
        let filter = CIFilter(name:"CIVignette")
        filter!.setValue(inputImage, forKey:kCIInputImageKey)
        filter!.setValue(2.5, forKey:"inputIntensity")
        filter!.setValue(1, forKey:"inputRadius")
        
        return UIImage(CGImage: context.createCGImage(filter!.outputImage!,
                fromRect: filter!.outputImage!.extent))
    
    }
}