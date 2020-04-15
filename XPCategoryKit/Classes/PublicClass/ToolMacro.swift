//
//  ToolMacro.swift
//  Cow
//
//  Created by xp on 2019/6/20.
//  Copyright © 2019 FaMiaoWang. All rights reserved.
//

import Foundation
import UIKit


struct Device {
    ///是否iphoneX系列机型 (刘海屏)
    static func isIPhoneXMore() -> Bool {
        var isMore:Bool = false
        if #available(iOS 11.0, *) {
            isMore = (UIApplication.shared.keyWindow?.safeAreaInsets.bottom)! > CGFloat(0.0)
        }
        return isMore
    }
    
    
    
    
    
    
    static let TOP_Height:CGFloat = Device.isIPhoneXMore() ? 88 : 64  //包含状态栏和导航栏高度
    
    
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    static let status = UIApplication.shared.statusBarFrame
//    static let tabBarHeight = CustomTabbar.shard.tabBar.height
    
    static let app_Version :String = {
        let mainBundle = Bundle.main.infoDictionary
        return mainBundle!["CFBundleShortVersionString"] as! String
    }()
    
    static let system_Version:String = {
        return UIDevice.current.systemVersion
    }()
    
    static let app_BundlleID:String = {
        let mainBundle = Bundle.main.infoDictionary
        return mainBundle!["CFBundleIdentifier"] as! String
    }()
    
    //获取infoplist中自定义字段
    static let aliPaySchemesUrl:String = {
        //此字段最终取自bulidSetting中自定义字段 $(AliPaySchemes)
        let mainBundle = Bundle.main.infoDictionary
        return mainBundle!["aliPayURLSchemes"] as! String
    }()
    
    
    /// wx- 回调链接
    static let universalLink = ""
    
    
    ///支付宝APP_id
    static let aliPayAppId = ""
    
    ///支付宝商户ID
    static let aliPayPid = ""
    
    ///微信App_Id
    static let weiXinAppId = ""
    
    ///微博App_id
    static let weiBoAPPId = ""
    static let weiBoAPPSecret = ""
    
    ///QQ App_id
    static let QQAppId = ""
    
    
    
    
    
    
    
    
    
    
    /// 5系列   =  (640*1136)   4寸
    static let is_iPhone5 = __CGSizeEqualToSize(CGSize.init(width: 640/2, height: 1136/2), UIScreen.main.bounds.size)
    
    /// 6s 7+ 8+   =  (750*1334)   4.7寸
    static let is_iPhone6 = __CGSizeEqualToSize(CGSize.init(width: 750/2, height: 1334/2), UIScreen.main.bounds.size)
    
    /// 6sp 7sp 8sp = (1242*2208)  5.5寸
    static let is_iPhone6Plus = __CGSizeEqualToSize(CGSize.init(width: 1242/3, height: 2208/3), UIScreen.main.bounds.size)
    
    /// x/xs系列。 (1125*2436)   5.8寸
    static let is_iPhoneX = __CGSizeEqualToSize(CGSize.init(width: 1125/3, height: 2436/3), UIScreen.main.bounds.size)
    
    /// XR系列。 (828*1792)   6.1寸
    static let is_iPhoneXR = __CGSizeEqualToSize(CGSize.init(width: 828/2, height: 1792/2), UIScreen.main.bounds.size)
    
    /// XS Max系列。 (1242*2688)   6.5寸
    static let is_iPhoneXMax = __CGSizeEqualToSize(CGSize.init(width: 1242/3, height: 2688/3), UIScreen.main.bounds.size)
}
