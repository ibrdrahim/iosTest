//
//  Overlay.swift
//  TestIOS
//
//  Created by Ibrahim Indosystem on 1/6/18.
//  Copyright © 2018 Ibrahim. All rights reserved.
//


import UIKit

public class LoadingOverlay{
    
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }
    
    public func showOverlay() {
        
        overlayView = UIView()
        
        if  let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let window = appDelegate.window {
            
            overlayView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
            overlayView.center = CGPoint(x: window.frame.width / 2.0, y: window.frame.height / 2.0)
            overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            overlayView.clipsToBounds = true
            
            let imageView = UIImageView(image: UIImage(named:"loading"))
            
            self.rotateView(targetView: imageView)
            
            imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            imageView.contentMode = .scaleAspectFit
            imageView.center = CGPoint(x: overlayView.bounds.width / 2.0, y: overlayView.bounds.height / 2.0)
            
            overlayView.addSubview(imageView)
            window.addSubview(overlayView)
            
            //activityIndicator.startAnimating()
        }
    }
    
    // Rotate <targetView> indefinitely
    private func rotateView(targetView: UIView, duration: Double = 3.5) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            targetView.transform = targetView.transform.rotated(by: .pi)
        }) { finished in
            self.rotateView(targetView: targetView, duration: duration)
        }
    }
    
    public func hideOverlay() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
    
    public func hideOverlayView() {
        DispatchQueue.main.async {
            LoadingOverlay.shared.hideOverlay()
        }
    }
}
