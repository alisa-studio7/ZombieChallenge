//
//  NavigationIndicator.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 17/3/21.
//

import UIKit

class NativeIndicator {
  static let shared = NativeIndicator()
  var container: UIView = UIView()
  var loadingView: UIView = UIView()
  var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
  
  func show(view: UIView) {
    container.frame = view.frame
    container.center = view.center
    container.backgroundColor = UIColor.clear
  
    loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
    loadingView.center = CGPoint(x: container.frame.size.width / 2, y: (container.frame.size.height / 2) - loadingView.frame.size.height)
    loadingView.backgroundColor = UIColor.black
    loadingView.alpha = 0.3
    loadingView.clipsToBounds = true
    loadingView.layer.cornerRadius = 10
    
    actInd.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
    actInd.style = UIActivityIndicatorView.Style.whiteLarge
    actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
    loadingView.addSubview(actInd)
    container.addSubview(loadingView)
    view.addSubview(container)
    actInd.startAnimating()
  }
  
  func hide() {
    container.removeFromSuperview()
  }
}
