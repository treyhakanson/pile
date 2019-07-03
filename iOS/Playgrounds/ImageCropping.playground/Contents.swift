
import UIKit
import XCPlayground

let view = UIView(frame: CGRectMake(0.0, 0.0, 375.0, 675.0))
view.backgroundColor = .whiteColor()
XCPlaygroundPage.currentPage.liveView = view

func resizeImage(image: UIImage, size: CGSize, fitMode: FitMode = .Clip) -> UIImage {
    
    var transform : CGAffineTransform = CGAffineTransformIdentity;
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(context, CGRectMake(0, 0, CGFloat(contextWidth), CGFloat(contextHeight)), image.CGImage);
    
    let cgImage = CGBitmapContextCreateImage(context);
    let imgRef = Util.CGImageWithCorrectOrientation(image)
    let originalWidth  = CGFloat(CGImageGetWidth(imgRef))
    let originalHeight = CGFloat(CGImageGetHeight(imgRef))
    let widthRatio = size.width / originalWidth
    let heightRatio = size.height / originalHeight
    
    let scaleRatio = widthRatio > heightRatio ? widthRatio : heightRatio
    
    let resizedImageBounds = CGRect(x: 0, y: 0, width: round(originalWidth * scaleRatio), height: round(originalHeight * scaleRatio))
    let resizedImage = Util.drawImageInBounds(image, bounds: resizedImageBounds)
    
    switch (fitMode) {
    case .Clip:
        return resizedImage
    case .Crop:
        let croppedRect = CGRect(x: (resizedImage.size.width - size.width) / 2,
                                 y: (resizedImage.size.height - size.height) / 2,
                                 width: size.width, height: size.height)
        return Util.croppedImageWithRect(resizedImage, rect: croppedRect)
    case .Scale:
        return Util.drawImageInBounds(resizedImage, bounds: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    }
}

