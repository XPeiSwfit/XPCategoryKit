//
//  NSObject+Extension.swift
//  Pods-XPCategoryKit_Tests
//
//  Created by admin on 2020/4/16.
//

import Foundation
protocol ClassName {
    
}

extension ClassName{
    ///截取类名
    static var typeName:String{
        return "\(type(of: self))".replacingOccurrences(of: ".Type", with: "")
    }
    
    var typeName:String{
        return "\(type(of: self))".replacingOccurrences(of: ".Type", with: "")
    }
}


extension NSObject:ClassName{
    
}

extension NSObject{
    ///获取当前活动的navigationController
    func getNavigationController()-> UINavigationController {
        var parent: UIViewController?
        if let window = UIApplication.shared.delegate?.window,let rootVC = window?.rootViewController {
            parent = rootVC
            while (parent?.presentedViewController != nil) {
                parent = parent?.presentedViewController!
            }
            
            if let tabbar = parent as? UITabBarController ,let nav = tabbar.selectedViewController as? UINavigationController {
                return nav
            }else if let nav = parent as? UINavigationController {
                return nav
            }
        }
        return UINavigationController()
    }
    
    ///当前VC
    func currentVC(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentVC(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentVC(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentVC(base: presented)
        }
        return base
    }
    
}
