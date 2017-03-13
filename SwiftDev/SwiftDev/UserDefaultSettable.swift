//
//  UserDefaultSettable.swift
//  SwiftDev
//
//  Created by yangjinxin on 2017/3/13.
//  Copyright © 2017年 yangjinxin. All rights reserved.
//

import Foundation
import UIKit

public protocol UserDefaultSettable {
    var uniqueKey: String { get }
}

public extension UserDefaultSettable where Self: RawRepresentable, Self.RawValue == String {
    
    public func store(value: Any?){
        UserDefaults.standard.set(value, forKey: uniqueKey)
    }
    
    public var storedValue: Any? {
        return UserDefaults.standard.value(forKey: uniqueKey)
    }
    
    public var uniqueKey: String {
        return "\(Self.self).\(rawValue)"
    }
    
    public func store(value: Bool) {
        UserDefaults.standard.set(value, forKey: uniqueKey)
    }
    
    public var storedBool: Bool {
        return UserDefaults.standard.bool(forKey: uniqueKey)
    }
    
    /// removed object from standard userdefaults
    public func removed() {
        UserDefaults.standard.removeObject(forKey: uniqueKey)
    }
}

extension UserDefaults {
    enum TestData: String, UserDefaultSettable {
        case name
        case url
    }
}
