//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))
containerView.backgroundColor = UIColor.whiteColor()
XCPShowView("Container View", view: containerView)

let youtubePlayer: UIWebView = UIWebView(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 300.0))
youtubePlayer.center = containerView.center
youtubePlayer.allowsInlineMediaPlayback = true
youtubePlayer.mediaPlaybackRequiresUserAction = false
containerView.addSubview(youtubePlayer)

let videoID: String = "v=SIYXVXrilGo"

let embededHTML = "<html><body style='margin:0px;padding:0px;'><script type='text/javascript' src='http://www.youtube.com/iframe_api'></script><script type='text/javascript'>function onYouTubeIframeAPIReady(){ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})}function onPlayerReady(a){a.target.playVideo();}</script><iframe id='playerId' type='text/html' width='\(youtubePlayer.frame.width)' height='\(youtubePlayer.frame.height)' src='http://www.youtube.com/embed/\(videoID)?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'></body></html>"

youtubePlayer.loadHTMLString(embededHTML, baseURL: NSBundle.mainBundle().bundleURL)