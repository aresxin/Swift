//
//  PreferenceManager.swift
//  SwiftDev
//
//  Created by yangjinxin on 2017/3/13.
//  Copyright © 2017年 yangjinxin. All rights reserved.
//

/*
 * Reference
 * http://www.cocoachina.com/ios/20170313/18867.html
 * https://github.com/hulizhen/FoxDemos/
 *
  在Swift中如果想让自定义类作为Key去访问某个集合中的元素，那么必须满足两个条件：
  用来访问集合元素的Key类型本身需要遵循Hashable协议。
  集合实现了subscript操作符，支持通过方括号[]访问集合元素。
 */


import Foundation
import UIKit

let Preferences = PreferenceManager.shared

final class PreferenceManager {
    static let shared = PreferenceManager()
    let defaults = UserDefaults.standard
    
    private init() {
        registerDefaultPreferences()
    }
    
    private func registerDefaultPreferences() {
        // Convert dictionary of type [PreferenceKey: Any] to [String: Any].
        let defaultValues: [String: Any] = defaultPreferences.reduce([:]) {
            var dictionary = $0
            dictionary[$1.key.rawValue] = $1.value
            return dictionary
        }
        defaults.register(defaults: defaultValues)
    }
}

extension PreferenceManager {
    subscript(key: PreferenceKey<Any>) -> Any? {
        get { return defaults.object(forKey: key.rawValue) }
        set { defaults.set(newValue, forKey: key.rawValue) }
    }
    
    subscript(key: PreferenceKey<URL>) -> URL? {
        get { return defaults.url(forKey: key.rawValue) }
        set { defaults.set(newValue, forKey: key.rawValue) }
    }
    
    subscript(key: PreferenceKey<[Any]>) -> [Any]? {
        get { return defaults.array(forKey: key.rawValue) }
        set { defaults.set(newValue, forKey: key.rawValue) }
    }
    
    subscript(key: PreferenceKey<[String: Any]>) -> [String: Any]? {
        get { return defaults.dictionary(forKey: key.rawValue) }
        set { defaults.set(newValue, forKey: key.rawValue) }
    }
    
    subscript(key: PreferenceKey<String>) -> String? {
        get { return defaults.string(forKey: key.rawValue) }
        set { defaults.set(newValue, forKey: key.rawValue) }
    }
    
    subscript(key: PreferenceKey<[String]>) -> [String]? {
        get { return defaults.stringArray(forKey: key.rawValue) }
        set { defaults.set(newValue, forKey: key.rawValue) }
    }
    
    subscript(key: PreferenceKey<Data>) -> Data? {
        get { return defaults.data(forKey: key.rawValue) }
        set { defaults.set(newValue, forKey: key.rawValue) }
    }
    
    subscript(key: PreferenceKey<Bool>) -> Bool {
        get { return defaults.bool(forKey: key.rawValue) }
        set { defaults.set(newValue, forKey: key.rawValue) }
    }
    
    subscript(key: PreferenceKey<Int>) -> Int {
        get { return defaults.integer(forKey: key.rawValue) }
        set { defaults.set(newValue, forKey: key.rawValue) }
    }
    
    subscript(key: PreferenceKey<Float>) -> Float {
        get { return defaults.float(forKey: key.rawValue) }
        set { defaults.set(newValue, forKey: key.rawValue) }
    }
    
    subscript(key: PreferenceKey<Double>) -> Double {
        get { return defaults.double(forKey: key.rawValue) }
        set { defaults.set(newValue, forKey: key.rawValue) }
    }
    
    subscript(key: PreferenceKey<UserInfo>) -> UserInfo? {
        get {
            var object: UserInfo?
            if let data = defaults.data(forKey: key.rawValue) {
                object = NSKeyedUnarchiver.unarchiveObject(with: data) as? UserInfo
            }
            return object
        }
        set {
            if let object = newValue {
                let data = NSKeyedArchiver.archivedData(withRootObject: object)
                defaults.set(data, forKey: key.rawValue)
            }
        }
    }
}

final class PreferenceKey<T>: PreferenceKeys { }

class PreferenceKeys: RawRepresentable, Hashable {
    let rawValue: String
    
    required init!(rawValue: String) {
        self.rawValue = rawValue
    }
    
    convenience init(_ key: String) {
        self.init(rawValue: key)
    }
    
    var hashValue: Int {
        return rawValue.hashValue
    }
}

extension PreferenceKeys {
    static let launchAtLogin = PreferenceKey<Bool>("LaunchAtLogin")
    static let launchCount = PreferenceKey<Int>("LaunchCount")
    static let userInfo = PreferenceKey<UserInfo>("UserInfo")
}

let defaultPreferences: [PreferenceKeys: Any] = [
    .launchAtLogin: false,
    .launchCount: 0,
    .userInfo: NSKeyedArchiver.archivedData(withRootObject: UserInfo(id: 0, name: "")),
]

//MARK: Test Model
// coder/encode
final class UserInfo: NSObject, NSCoding {
    var id = 0
    var name = ""
    
    convenience init(id: Int, name: String) {
        self.init()
        
        self.id = id
        self.name = name
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        
        for child in Mirror(reflecting: self).children {
            if let key = child.label {
                setValue(aDecoder.decodeObject(forKey: key), forKey: key)
            }
        }
    }
    
    func encode(with aCoder: NSCoder) {
        for child in Mirror(reflecting: self).children {
            if let key = child.label {
                aCoder.encode(value(forKey: key), forKey: key)
            }
        }
    }
}
