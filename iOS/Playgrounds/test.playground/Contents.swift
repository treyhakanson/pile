//: Playground - noun: a place where people can play

import UIKit

struct ImageManager {
    var imgs: [UIImage] = []
    
    subscript(i: Int) -> UIImage {
        get {
            print("index: \((i == 0) ? 0 : (i/10 + 1 < imgs.count) ? i/10 + 1 : imgs.count - 1)")
            return ((i == 0) ? imgs[0] : imgs[(i/10 + 1 < imgs.count) ? i/10 + 1 : imgs.count - 1])
        }
    }
    
    init(imgs: UIImage...) {
        self.imgs = imgs
    }
    
}

let imageManager = ImageManager(imgs: UIImage(), UIImage(), UIImage(), UIImage(), UIImage())

let img = imageManager[10] // use the number of clicks as your subscript, manipulate image as you please

