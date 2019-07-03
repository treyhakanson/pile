//
//  SquareYouTubeView.swift
//  YouTube Test
//
//  Created by David Hakanson on 4/24/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit

class SquareYouTubeView: UIView {
    
    private var youtubeWebView = UIWebView()
    private var cropFactor: CGFloat = 0.0
    private var videoId: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = true
        
        self.youtubeWebView = UIWebView()
        self.addSubview(youtubeWebView)
        self.youtubeWebView.center = CGPoint(x: self.frame.width/2.0, y: self.frame.height/2.0)
        self.youtubeWebView.allowsInlineMediaPlayback = true
        self.youtubeWebView.mediaPlaybackRequiresUserAction = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, cropFactor: CGFloat, videoId: String) {
        super.init(frame: frame)
        
        self.cropFactor = cropFactor
        self.videoId = videoId
        self.clipsToBounds = true
        
        self.youtubeWebView = UIWebView()
        self.addSubview(youtubeWebView)
        self.youtubeWebView.center = CGPoint(x: self.frame.width/2.0, y: self.frame.height/2.0)
        self.youtubeWebView.allowsInlineMediaPlayback = true
        self.youtubeWebView.mediaPlaybackRequiresUserAction = false
        
        self.setCropFactor(cropFactor: self.cropFactor)
        self.embedVideo(youTubeVideoId: self.videoId)
        
    }
    
    func setCropFactor(cropFactor factor: CGFloat) {
        self.cropFactor = factor
        self.youtubeWebView.frame = CGRectMake(0, 0, self.frame.width*self.cropFactor, self.frame.height*self.cropFactor)
        self.youtubeWebView.center = CGPoint(x: self.frame.width/2.0, y: self.frame.height/2.0)
    }
    
    func embedVideo(youTubeVideoId id: String) {
        self.videoId = id
        
        let embededHTML = "<html><body style='margin:0px;padding:0px;'><script type='text/javascript' src='http://www.youtube.com/iframe_api'></script><script type='text/javascript'>function onYouTubeIframeAPIReady(){ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})}function onPlayerReady(a){a.target.playVideo();}</script><iframe id='playerId' type='text/html' width='\(self.youtubeWebView.frame.width)' height='\(self.youtubeWebView.frame.height)' src='http://www.youtube.com/embed/\(self.videoId)?enablejsapi=1&autoplay=1&auothide=1&playsinline=1&controls=0&rel=0&fs=0&loop=1&modestbranding=1&showinfo=0' frameborder='0'></body></html>"
        
        self.youtubeWebView.loadHTMLString(embededHTML, baseURL: NSBundle.mainBundle().bundleURL)
        
        print("self.frame: \(self.frame)")
        print("self.youTubeWebView.frame: \(self.youtubeWebView.frame)")
    }
    
}
