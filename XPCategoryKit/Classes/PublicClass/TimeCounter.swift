//
//  TimeCounter.swift
//  Cow
//
//  Created by xp on 2019/8/23.
//  Copyright © 2019 FaMiaoWang. All rights reserved.
//

import Foundation

///一个计时器,基于ios 10.0系统之上

@objc
public protocol TimerListener: class {
    func didOnTimer(announcer: TimeCounter, timeInterval: TimeInterval)
}

public class TimeCounter:NSObject{
   public static let sharedInstance = TimeCounter()
    
    ///红色⚠️...    注意管理好使用的协议类， 注意下面这个数组, 在不使用的时候，切记删除，这个计时器是单例, 如果没有管理好，再次进入的时候，可能会出现计时错误，或停止的bug
    private let map:NSHashTable<TimerListener> = NSHashTable<TimerListener>.weakObjects()
    
    
    private override init() {
        super.init()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {[weak self] (ti) in
            guard let self = self else{
                ti.invalidate()
                return
            }
            self.onTimer()
            
        }
        timerPause()
        
    }
    
    /// 获取时间戳， 根据时间的变化而变化，倒计时便是基于此而来
    var nowTimeInterval = Date().timeIntervalSince1970
    
    private var timer : Timer?
    
    private func onTimer() {
        
        nowTimeInterval =  Date().timeIntervalSince1970 + serverTimeInterval
        
        for listener in self.map.allObjects {
            listener.didOnTimer(announcer: self, timeInterval: self.nowTimeInterval)
        }
    }
    
   public func addListener(listener: TimerListener) {
        
        if !map.contains(listener){ //如果存在则不再添加
            map.add(listener)
        }
    }
    
    /// 和服务器时间差,用于服务器时间同步
    var serverTimeInterval: TimeInterval = 0
    /// 从服务器请求最新的时间
    @objc private func resetServerTime() {
        
//        FMRequest.call(path: Api.sendSystemDate).startWithResult{[weak self] (res) in
//            guard let self = self else{return}
//            switch res{
//            case .success(let value):
//                let systemNowTime = value.resData as! Double
//
//                self.serverTimeInterval = systemNowTime/1000 - Date().timeIntervalSince1970
//                log.debug(systemNowTime,Date().timeIntervalSince1970, "差值 \(self.serverTimeInterval)")
//
//            case .failure(let err): ProgressHUD.showInfo(err.domain)
//            // 如果请求失败，隔一段时间再请求一次
//            self.perform(#selector(self.resetServerTime), with: nil, afterDelay: 15)
//            }
//        }
        
    }
    
    
    /// 删除所有存储的协议类
    ///
    /// - Parameter listener: 为空则清除所有，
   public func removeListener(listener: TimerListener?){
        if listener.isSome{
            map.remove(listener)
        }else{
            map.removeAllObjects()
            timerPause()
        }
        
    }
    
    /// 当没有定时器需求的时候暂停定时器
   public func timerPause() {
        timer?.fireDate = Date.distantFuture
    }
    
    /// 启动定时器
   public func timerStart() {
        resetServerTime()
        timer?.fireDate = Date.distantPast
    }
    
    /// 提供时间差值计算方法
    ///
    /// - Parameter time: 比如限时活动开始时间、结束时间, （结束时间也需要处理服务器时间差值）
    /// - Returns: 时间差
   public func lefTimeInterval(time: TimeInterval) -> TimeInterval {
        let leftTime = time + serverTimeInterval - self.nowTimeInterval
        return leftTime
    }
    
    
    
    
    deinit {
        
        timer?.invalidate()
        timer = nil
    }
}
