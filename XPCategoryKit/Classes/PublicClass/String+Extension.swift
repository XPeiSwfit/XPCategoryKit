//
//  String+Extension.swift
//  Pods-XPCategoryKit_Tests
//
//  Created by admin on 2020/4/16.
//

import Foundation
public extension String{
    
    
    /// 处理前缀不是”/“的，前面进行添加“/”
    func  isValidFirstSlash() -> String{
        guard hasPrefix("/") else {
            return "/" + self
        }
        return self
    }
    
    
    /// 字符串的千分位计算  默认保留2位小数
    ///
    /// "1.3456".financingMoneyFormater(prefix: "¥") -> ¥1.34
    /// "1.3456".financingMoneyFormater(max:3,prefix: "$") -> $1.345
    ///
    ///
    ///   - digits: 保留小数位  默认保留2位
    ///   - prefix: 金额前缀    默认不添加
    func financingMoneyFormater(digits:Int = 2,prefix:String? = nil) -> String{
        if self.isEmpty{ return "0.00"}
        
        guard let s = Double(self)?.toString(min: digits) else{
            return "0.00"
        } //截取后
        
        let number = NSNumber(value: Double(s) ?? 0.00)
        let format = NumberFormatter()
        format.numberStyle = .none
        format.positivePrefix = prefix
        format.minimumFractionDigits = digits
        format.minimumIntegerDigits = 1
        return format.string(from: number)!
        
        
    }
   
           
    ///关于金额千分位分隔，double转string
    ///
    ///     String.turnTwoDecimalPlaces(1.3456) -> 1.34
    ///     String.turnTwoDecimalPlaces(1.3456, 3, prefix: "¥") -> ¥1.345
    ///
    /// - Parameters:
    ///   - price: 金额
    ///   - digits: 保留小数位  默认保留2位
    ///   - prefix: 金额前缀    默认不添加
    static func turnTwoDecimalPlaces(_ price:Double, digits:Int = 2,prefix:String? = nil) -> String{
        guard price.isNormal else{ return "￥0.00"}
        
        let s = price.toString(min: digits)  //截取后
        
        let number = NSNumber(value: Double(s)!)
        let format = NumberFormatter()
        format.positivePrefix = prefix
        format.numberStyle = .none
        format.minimumFractionDigits = digits
        format.minimumIntegerDigits = 1
        return format.string(from: number)!
    }
    
    
    
    ///剩余秒数，转时分秒
    static func TurnSecondTime(t:Int) ->String{
        let hours = t / 60 / 60
        let H = hours > 9 ? "\(hours)" : "0\(hours)"
        
        let  minutes = (t%3600) / 60
        let  m = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        
        
        let seconds = t % 60
        let s = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        
        guard H == "00" else{
            return "\(H):\(m):\(s)"
        }
        
        return "\(m):\(s)"
        
    }
    
    /// 计算文字所需宽度
    ///
    /// - Parameters:
    ///   - fontSize: 文字的字号大小
    ///   - height: 最大高度
    /// - Returns: 宽度
    func pn_widthForComment(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    /// 计算文字所需高度
    ///
    /// - Parameters:
    ///   - fontSize: 文字的字号大小
    ///   - width: 最大宽度
    ///   - maxHeight : 可接受最大高度
    /// - Returns: 高度
    
    func pn_heightForComment(font: UIFont, width: CGFloat, maxHeight: CGFloat = 1115) -> CGFloat {
        
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(rect.height)>maxHeight ? maxHeight : ceil(rect.height)
    }
    
    
    
    
    
    /// 根据需要设置的string 设置富文本
    ///
    /// - Parameter dict: 需要设置的富文本数据
    func setAttributedText(dict: [String:[NSAttributedString.Key : Any]]) -> NSMutableAttributedString{
        
        let matt = NSMutableAttributedString(string: self )
        
        for (key,value) in dict{
            
            if let range = self.range(of: key, options: .backwards){
                
                let keyLocation = self.distance(from: self.startIndex, to: range.lowerBound)
                let KeyLength = self.distance(from: range.lowerBound, to: range.upperBound)
                matt.addAttributes(value, range: NSMakeRange(keyLocation, KeyLength))
            }
        }
        
        return matt
        
    }
}

public extension Double{
    ///double转string 设置最低小数位,不足小数位用0补齐
    func toString(min:Int = 2) -> String{
        
        let str = String(self)
        let ind = str.firstIndex(of: ".")  //这里使用截取
        
        guard ind != nil  else {
            return str
        }
        
        guard  min != 0 else{ //
            return String( str[str.startIndex..<ind!])
        }
        
        let subStrCount = str.suffix(from: ind!).count
        
        var newStr:String = ""
        switch subStrCount {
        case 2:
            let e = str.index(ind!, offsetBy: subStrCount)
            newStr = str[str.startIndex..<e] + "0"
        case 1 :
            let e = str.index(ind!, offsetBy: subStrCount)
            newStr = str[str.startIndex..<e] + "00"
        default:
            let endIndex = str.index(ind!, offsetBy: min+1)
            newStr = String(str[str.startIndex..<endIndex])
        }
        
        return newStr
    }
}


public extension String {
    /// 截取到任意位置
    func subString(to: Int) -> String {
        guard self.count > to else{ return self}
        let index: String.Index = self.index(startIndex, offsetBy: to)
        return String(self[..<index])
    }
    
    /// 从任意位置开始截取
    func subString(from: Int) -> String {
        let index: String.Index = self.index(startIndex, offsetBy: from)
        return String(self[index ..< endIndex])
    }
    
    /// 从任意位置开始截取到任意位置
    func subString(from: Int, to: Int) -> String {
        let beginIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[beginIndex...endIndex])
    }
    
    ///使用下标截取到任意位置
    subscript(to: Int) -> String {
        let index = self.index(self.startIndex, offsetBy: to)
        return String(self[..<index])
    }
    
    
    ///使用下标从任意位置开始截取到任意位置
    subscript(from: Int, to: Int) -> String {
        let beginIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[beginIndex...endIndex])
    }
    
    /// 替换指定位置范围内的字符为 “****”
    ///
    /// - Parameters:
    ///   - startLocation: 开始的字符下标
    ///   - endLocation: 结束的字符下标
    /// - Returns: 替换过后的s字符
    func replacingRangStr(startLocation:Int , endLocation:Int) -> String{
        guard self.count >= endLocation else {
            return self
        }
        let startIndex = self.index(self.startIndex, offsetBy: startLocation)
        let endIndex =  self.index(self.startIndex, offsetBy: endLocation)
        let rang =  Range(uncheckedBounds: (startIndex,endIndex))
        let la = self.count < 5 ? "**" : "****"
        return self.replacingCharacters(in: rang, with: la)
    }
}


public extension String{

    /// "一是中文".isAllChineseIn  ->  true
    /// "1不是中文".isAllChineseIn ->  false
    /// 判断字符串是否全部是中文
    func isAllChineseIn() -> Bool {
        
        var result = true
        for (_, value) in self.enumerated() {
            ///中文判断条件
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                result = true
            }else{
                result = false
                break
            }
        }
        
        return result
    }
}
