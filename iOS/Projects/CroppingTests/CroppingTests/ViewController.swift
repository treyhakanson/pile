//
//  ViewController.swift
//  CroppingTests
//
//  Created by David Hakanson on 8/3/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

extension AVAsset {
    
    func generateThumbnail() -> UIImage {
        do {
            let generator = AVAssetImageGenerator(asset: self)
            let image = try generator.copyCGImageAtTime(CMTimeMake(0, 1), actualTime: nil)
            return UIImage(CGImage: image)
        } catch {
            print("###########################")
            print("Thumbnail Generation Failed")
            print("###########################")
        }
        return UIImage()
    }
    
}

extension UIImage {
    public func imageRotatedByDegrees(degrees: CGFloat, flip: Bool) -> UIImage {
        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat(M_PI)
        }
        
        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(origin: CGPointZero, size: size))
        let t = CGAffineTransformMakeRotation(degreesToRadians(degrees));
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        CGContextTranslateCTM(bitmap, rotatedSize.width / 2.0, rotatedSize.height / 2.0);
        
        //   // Rotate the image context
        CGContextRotateCTM(bitmap, degreesToRadians(degrees));
        
        // Now, draw the rotated/scaled image into the context
        var yFlip: CGFloat
        
        if(flip){
            yFlip = CGFloat(-1.0)
        } else {
            yFlip = CGFloat(1.0)
        }
        
        CGContextScaleCTM(bitmap, yFlip, -1.0)
        CGContextDrawImage(bitmap, CGRectMake(-size.width / 2, -size.height / 2, size.width, size.height), CGImage)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

class ViewController: UIViewController {
    
    enum VideoOrientation {
        case Portrait
        case LandscapeLeft
        case LandscapeRight
        case UpsideDown
    }
    
    var pinchGestureRecognizer: UIPinchGestureRecognizer = UIPinchGestureRecognizer()
    var panGestureRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer()
    var lastTouchDownLocation: CGPoint = CGPointZero
    
    var imageView: UIImageView = UIImageView()
    var containerView: UIView = UIView()
    
    var mediaAsset: AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.scaleImage(_:)))
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.moveImage(_:)))
        
        let containerSize = UIScreen.mainScreen().bounds.width
        containerView = UIView(frame: CGRectMake(0.0, 0.0, containerSize, containerSize))
        containerView.clipsToBounds = true
        containerView.userInteractionEnabled = true
        
        let lowerViewSize = UIScreen.mainScreen().bounds.height - containerSize
        let lowerView = UIView(frame: CGRectMake(0.0, containerSize, containerSize, lowerViewSize))
        lowerView.userInteractionEnabled = true
        lowerView.backgroundColor = .whiteColor()
        
        let title = NSAttributedString(string: "Done Cropping", attributes: [
            NSFontAttributeName : UIFont(name: "Avenir-Heavy", size: 18.0)!,
            NSForegroundColorAttributeName : UIColor.whiteColor()
        ])
        let doneButton = UIButton(frame: CGRectMake(0.0, 0.0, 150.0, 50.0))
        doneButton.setAttributedTitle(title, forState: .Normal)
        doneButton.backgroundColor = UIColor(red: 58.0/255.0, green: 223.0/255.0, blue: 205.0/255.0, alpha: 1.0)
        doneButton.addTarget(self, action: #selector(ViewController.crop), forControlEvents: .TouchUpInside)
        doneButton.layer.cornerRadius = 50.0/12.0
        doneButton.center.x = self.view.center.x
        doneButton.center.y = lowerViewSize/2.0
        lowerView.addSubview(doneButton)
        
        let cropGridView = CropView(frame: CGRectMake(0.0, 0.0, containerSize, containerSize))
        cropGridView.userInteractionEnabled = false
        cropGridView.setColor(.blackColor())
        
        imageView.userInteractionEnabled = true
        imageView.frame = CGRectZero
        imageView.gestureRecognizers = [
            panGestureRecognizer,
            pinchGestureRecognizer
        ]
        
        if let video = mediaAsset as? AVAsset {
            var image = video.generateThumbnail()
            switch getVideoOrientation(video.tracksWithMediaType(AVMediaTypeVideo).first!)! {
            case .LandscapeLeft:
                break
            case .Portrait:
                image = image.imageRotatedByDegrees(90.0, flip: false)
                break
            case .LandscapeRight:
                image = image.imageRotatedByDegrees(180.0, flip: false)
            case .UpsideDown:
                image = image.imageRotatedByDegrees(270.0, flip: false)
            }
            imageView.image = image
            let sizeRatio = imageView.image!.size.height/imageView.image!.size.width
            imageView.frame = (sizeRatio > 1.0) ?
                CGRectMake(0.0, 0.0, containerSize, containerSize*sizeRatio) :
                CGRectMake(0.0, 0.0, containerSize/sizeRatio, containerSize)
            imageView.center.x = self.view.center.x
        } else if let image = mediaAsset as? UIImage {
            imageView.image = image
            imageView.sizeToFit()
            imageView.center.x = self.view.center.x
        } else {
            // TODO: Show Popup
            print("Something Went Wrong")
        }
        
        containerView.addSubview(imageView)
        containerView.addSubview(cropGridView)
        self.view.addSubview(containerView)
        self.view.addSubview(lowerView)
        
    }

    func scaleImage(sender: UIPinchGestureRecognizer!) {
        guard let _ = mediaAsset as? UIImage else { return }
        
        let scale = sender.scale
        
        let excessX = imageView.frame.width * scale - imageView.superview!.frame.width
        let excessY = imageView.frame.height * scale - imageView.superview!.frame.height
        
        let superviewHeight = imageView.superview!.frame.height
        let newHeight = imageView.frame.height * scale
        if newHeight < superviewHeight {
            return
        }
        
        let superviewWidth = imageView.superview!.frame.width
        let newWidth = imageView.frame.width * scale
        if newWidth < superviewWidth {
            return
        }
        
        imageView.transform = CGAffineTransformScale(imageView.transform, sender.scale, sender.scale)
        sender.scale = 1
        
        if abs(imageView.frame.origin.x) > excessX {
            imageView.frame.origin.x = -excessX
        } else if imageView.frame.origin.x > 0.0 {
            imageView.frame.origin.x = 0.0
        }
        if abs(imageView.frame.origin.y) > excessY {
            imageView.frame.origin.y = -excessY
        } else if imageView.frame.origin.y > 0.0 {
            imageView.frame.origin.y = 0.0
        }
        
    }
    
    func moveImage(sender: UIPanGestureRecognizer!) {
        let translation  = sender.translationInView(imageView.superview!)
        
        let newX = lastTouchDownLocation.x + translation.x
        let newY = lastTouchDownLocation.y + translation.y
        
        let excessX = imageView.frame.width - imageView.superview!.frame.width
        let excessY = imageView.frame.height - imageView.superview!.frame.height
        
        var realX: CGFloat = lastTouchDownLocation.x
        if excessX > 0.0 && newX < 0.0 && abs(newX) < excessX { // x can move
            realX = newX
        } else if excessX == 0.0 { // no excess to work with
            realX = 0.0 // lock x at 0.0
        } else if newX > 0.0 { // at right bound
            realX = 0.0 // x cannot move further into the positive than right bound
        } else if abs(newX) > excessX { // at left bound
            realX = -excessX // x cannot move further negative than left bound
        }
        
        var realY: CGFloat = lastTouchDownLocation.y
        if excessY > 0.0 && newY < 0.0 && abs(newY) < excessY { // y can move
            realY = newY
        } else if excessY == 0.0 { // no excess to work with
            realY = 0.0 // lock y at 0.0
        } else if newY > 0.0 { // at lower bound
            realY = 0.0 // y cannot move further positive than lower bound
        } else if abs(newY) > excessY { // at upper bound
            realY = -excessY // y cannot move further negative than upper bound
        }
        
        imageView.frame.origin = CGPoint(x: realX, y: realY)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        lastTouchDownLocation = imageView.frame.origin
    }
    
    func crop() {
        let scale = imageView.transform.a
        let xOffset = abs(imageView.frame.origin.x)/scale
        let yOffset = abs(imageView.frame.origin.y)/scale
        
        let cropWidth = containerView.frame.width/scale
        let cropHeight = containerView.frame.height/scale
        let croppedRect = CGRectMake(xOffset, yOffset, cropWidth, cropHeight)
        
        if let video = mediaAsset as? AVAsset {
            checkVideoLength(video, croppedRect: croppedRect)
        } else if let image = mediaAsset as? UIImage {
            cropImage(image, croppedRect: croppedRect)
        } else {
            print("Something Went Wrong")
        }
        
    }
    
    func checkVideoLength(video: AVAsset, croppedRect: CGRect) {
        if video.duration > CMTimeMake(59, 1) {
            // TODO: Make this a HatchliAlert
            let alert = UIAlertController(title: "Warning: Video Length Exceeds 1 Minute", message: "Videos over 1 minute long will be cut off at the 1 minute mark for posting purposes.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "cancel", style: .Cancel, handler: { (action) in
                alert.dismissViewControllerAnimated(false, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "ok", style: .Default , handler: { (action) in
                alert.dismissViewControllerAnimated(false, completion: nil)
                self.cropVideo(video, croppedRect: croppedRect)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            self.cropVideo(video, croppedRect: croppedRect)
            
        }
        
    }
    
    func cropVideo(video: AVAsset, croppedRect: CGRect) {
        print("Cropping Video")
        guard let track = video.tracksWithMediaType(AVMediaTypeVideo).first else { return }
        guard let orientation = getVideoOrientation(track) else { print("An Error Occurred"); return }
        print("Created Track Video (\(orientation))")
        let dimension = min(track.naturalSize.height, track.naturalSize.width)
        let videoComp = AVMutableVideoComposition()
        videoComp.frameDuration = CMTimeMake(1, 30)
        videoComp.renderSize = CGSizeMake(dimension, dimension)
        
        let widthRatio = imageView.image!.size.width/imageView.frame.width
        let heightRatio = imageView.image!.size.height/imageView.frame.height
        
        let transformer: AVMutableVideoCompositionLayerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: track)
        
        var finalTransform = track.preferredTransform
        switch  orientation {
        case .Portrait:
            finalTransform = CGAffineTransformTranslate(track.preferredTransform, -croppedRect.origin.y*heightRatio, 0.0)
        case .LandscapeLeft:
            finalTransform = CGAffineTransformTranslate(track.preferredTransform, -croppedRect.origin.x*widthRatio, 0.0)
        case .LandscapeRight:
            finalTransform = CGAffineTransformTranslate(track.preferredTransform, croppedRect.origin.x*widthRatio, 0.0)
        case .UpsideDown:
            finalTransform = CGAffineTransformTranslate(track.preferredTransform, croppedRect.origin.y*heightRatio, 0.0)
        }
        transformer.setTransform(finalTransform, atTime: kCMTimeZero)
        
        let instruction = AVMutableVideoCompositionInstruction()
        instruction.timeRange = CMTimeRangeMake(kCMTimeZero, CMTimeMakeWithSeconds(60, 30))
        instruction.layerInstructions = [transformer]
        videoComp.instructions = [instruction]
        
        let exporter = AVAssetExportSession(asset: video, presetName: AVAssetExportPresetHighestQuality)
        exporter?.videoComposition = videoComp
        exporter?.outputFileType = AVFileTypeQuickTimeMovie
        
        var videoOutputUrl = NSTemporaryDirectory()
        videoOutputUrl = videoOutputUrl.stringByAppendingString("/" + String(NSDate.timeIntervalSinceReferenceDate()))
        videoOutputUrl = videoOutputUrl.stringByAppendingString(".mov")
        
        exporter?.outputURL = NSURL(fileURLWithPath: videoOutputUrl as String)
        let duration = min(Int64(video.duration.value), 59)
        exporter?.timeRange = CMTimeRangeMake(CMTimeMake(0, 1), CMTimeMake(duration, 1))
        exporter?.exportAsynchronouslyWithCompletionHandler({
            print("Video Successfully Cropped")
            
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                PHAssetChangeRequest.creationRequestForAssetFromVideoAtFileURL(NSURL(fileURLWithPath: videoOutputUrl as String))
            }) { saved, error in
                if saved {
                    print("Video Saved to Library Successfully.")
                }
            }
            
        })
        
    }
    
    func cropImage(image: UIImage, croppedRect: CGRect) {
        if let croppedImage = CGImageCreateWithImageInRect(imageView.image?.CGImage, croppedRect) {
            print("Image Successfully Cropped:")
            print(croppedImage)
            
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                PHAssetChangeRequest.creationRequestForAssetFromImage(UIImage(CGImage: croppedImage))
            }) { saved, error in
                if saved {
                    print("Image Saved to Library Successfully.")
                }
            }
            
        } else {
            // TODO: Show Popup
            print("An Error Occurred")
        }
        
    }
    
    func getVideoOrientation(track: AVAssetTrack) -> VideoOrientation? {
        let size = track.naturalSize
        let transform = track.preferredTransform
        if size.height == transform.tx && transform.ty == 0.0 {
            return .Portrait
        }
        else if transform.tx == 0.0 && transform.ty == 0.0 {
            return .LandscapeLeft
        }
        else if size.height == transform.ty && size.width == transform.tx {
            return .LandscapeRight
        }
        else if size.width == transform.ty && transform.tx == 0.0 {
            return .UpsideDown
        }
        return nil
        
    }
    
}

