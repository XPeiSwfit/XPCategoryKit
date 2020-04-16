//
//  FMNotification.swift
//  Cow
//
//  Created by xp on 2019/6/20.
//  Copyright © 2019 FaMiaoWang. All rights reserved.
//

import UIKit
/*使用。扩展一个Notification.Name*/
internal typealias NotificationCallBackBlock = (EventInfo) -> Void

class FMNotification {

    var observers = [Notification.Name : Observer]()
    
    weak var own :AnyObject?  //拥有者
    
    init(_ obj :AnyObject) {
        self.own = obj
    }
    
    ///订阅事件
    func subscribe(eventName:Notification.Name,callBack:@escaping NotificationCallBackBlock){
        if self.observers[eventName] != nil{
            return print("重复订阅 \(eventName)")
        }
        
        self.observers[eventName] = Observer.subscriber(eventName, block: callBack)
    }
    
    /// 发布事件
    func sendNotifacation(_ eventName:Notification.Name, userInfo:[AnyHashable:Any]?) -> Void{
        NotificationCenter.default.post(name: eventName, object: self, userInfo: userInfo)
    }
    
    /// 取消订阅
    func unSubscribe(_ eventName:Notification.Name){
        self.observers.removeValue(forKey: eventName)
    }
    
    deinit {
        self.observers.removeAll()
    }
    
}



/// notifacation实际订阅类
class Observer {
    let eventName : Notification.Name
    let block : NotificationCallBackBlock
    
    init(eventName:Notification.Name,block:@escaping NotificationCallBackBlock) {
        self.eventName = eventName
        self.block = block
    }
    
    class func subscriber(_ eventName:Notification.Name, block:@escaping NotificationCallBackBlock) -> Observer{
        
        let obs = Observer(eventName: eventName, block: block)
        
        NotificationCenter.default.addObserver(obs, selector: #selector(Observer.notifacationCallBack(_:)), name: eventName, object: nil)
        
        return obs
    }
    
    //最终订阅方法。和订阅回调执行
   @objc func notifacationCallBack(_ nt:Notification){
        let event = EventInfo(eventName: nt.name, observer: nt.object, userInfo: nt.userInfo)
        block(event)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: eventName, object: nil)
    }
}


/// notifacation事件信息
class EventInfo{  
    
    let eventName:Notification.Name  
    let observer : Any?
    let userInfo:[AnyHashable : Any]?
    
    init(eventName:Notification.Name,
         observer:Any?,
        userInfo:[AnyHashable : Any]?) {
        
        self.userInfo = userInfo
        self.eventName = eventName
        self.observer = observer
        
    }
}

private var FMNotificationKey = "FMNotificationKey"

extension NSObject{
    var notifacation:FMNotification{
    
        get {
            objc_sync_enter(self)
            defer {
               objc_sync_exit(self) 
            }
            
            var obj = objc_getAssociatedObject(self, &FMNotificationKey)
            if(obj != nil){
                return obj as! FMNotification
            }
            
            obj = FMNotification.init(self)
            objc_setAssociatedObject(self, &FMNotificationKey, obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            return obj as! FMNotification
        }
        
    }
}
