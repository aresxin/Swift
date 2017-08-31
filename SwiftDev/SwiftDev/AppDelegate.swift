//
//  AppDelegate.swift
//  SwiftDev
//
//  Created by yangjinxin on 2017/2/27.
//  Copyright © 2017年 yangjinxin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

//        NSSetUncaughtExceptionHandler(CustomUncaughtExceptionHandler())

//        NSSetUncaughtExceptionHandler {exception in
//            print(">>>>> ExceptionHandler OK")
//            let arr = exception.callStackSymbols//得到当前调用栈信息
//            let reason = exception.reason//非常重要，就是崩溃的原因
//            let name = exception.name//异常类型
//
//            NSLog("exception type : \(name) \n crash reason : \(String(describing: reason)) \n call stack info : \(arr)");
//
//            let log = NSString(format:"%@, %@", exception.name as CVarArg, exception.reason!)
//            UserDefaults.standard.setValue("crash", forKey: "failLog")
//            UserDefaults.standard.synchronize()
//        }


        exceptionLogWithData()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


func CustomUncaughtExceptionHandler() -> @convention(c) (NSException) -> Void {
    return { (exception) -> Void in
        let arr = exception.callStackSymbols//得到当前调用栈信息
        let reason = exception.reason//非常重要，就是崩溃的原因
        let name = exception.name//异常类型

        NSLog("exception type : \(name) \n crash reason : \(String(describing: reason)) \n call stack info : \(arr)");


    }
}


func exceptionLogWithData() {
    setDefaultHandler()
    let str = getdataPath()
//    do {
//        try FileManager.default.removeItem(atPath: str)
//    } catch {
//
//    }

    let data = NSData.init(contentsOfFile: str)
    if data != nil {
        let crushStr = String.init(data: data as! Data, encoding: String.Encoding.utf8)
        print(crushStr!)
    }


    signal(SIGABRT) { (_) in
        print("symobs is \(Thread.callStackSymbols)")
    }
    signal(SIGILL) { (_) in
        print("symobs is \(Thread.callStackSymbols)")
    }

    signal(SIGSEGV) { (_) in
        print("symobs is \(Thread.callStackSymbols)")
    }
    signal(SIGFPE) { (_) in
        print("symobs is \(Thread.callStackSymbols)")
    }
    signal(SIGBUS) { (_) in
        print("symobs is \(Thread.callStackSymbols)")
    }

    signal(SIGPIPE) { (_) in
        print("symobs is \(Thread.callStackSymbols)")
    }


    let arry = ["1"]
    print("%@",arry[20])

    //测试数据
//    let arry:NSArray = ["1"]
//    print("%@",arry[20])
}


