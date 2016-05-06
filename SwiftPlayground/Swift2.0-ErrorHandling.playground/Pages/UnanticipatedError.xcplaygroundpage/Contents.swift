//: [Previous](@previous)

import Foundation
import UIKit
import MobileCoreServices

public enum OBSError: ErrorType {
    public static let Domain = "com.linecorp.obs"
    
    case OBSURLRequired
    case CDNURLRequired
    
    case ServiceCodeRequired
    
    case TokenRequired
    case AdditioonalAuthenticationRequired
    
    case InvalidResponse
    case InvalidHashID
    case InvalidOBSURL
    case InvalidCDNURL
    
    case Unknow
    
    public var error: NSError {
        return self.withErrorRecoveryAttempter()
    }
    
    public var code: Int {
        switch self {
        case OBSURLRequired:
            return 1003
        default:
            return 1004
        }
    }
    
    public var userInfo:[NSObject: AnyObject] {
        let info = [NSLocalizedRecoverySuggestionErrorKey: "OBSError"]
        return info
    }
    
    public var localizedRecoveryOptions: [String] {
         return [NSLocalizedString("OK", comment:""), NSLocalizedString("Copy details", comment:"")]
    }
    
    func attemptRecoveryFromError(error: NSError, optionIndex: Int) -> Bool
    {
        switch self {
        case OBSURLRequired:
            // Post Notification
            return true
        default:
            return false
        }
    }
    
}

public extension ErrorType {
    
    public func withErrorRecoveryAttempter(file file: String = #file, line: Int = #line) -> NSError {
        let e = self as! OBSError
        var userInfo: [NSObject: AnyObject] = e.userInfo
        if let previousSuggestion = userInfo[NSLocalizedRecoverySuggestionErrorKey] {
            userInfo[UnanticipatedErrorRecoveryAttempter.PreviousRecoverySuggestionKey] = previousSuggestion
        }
        
        let directory = ((file as NSString).stringByDeletingLastPathComponent as NSString).lastPathComponent
        let filename = (file as NSString).lastPathComponent
        let suggestion = NSString(format: NSLocalizedString("The error occurred at line %ld of the %@/%@ file in the program's code.",  comment: ""), line, directory, filename)
        userInfo[NSLocalizedRecoverySuggestionErrorKey] = suggestion
        
        
        userInfo[NSLocalizedRecoveryOptionsErrorKey] = e.localizedRecoveryOptions
        userInfo[NSRecoveryAttempterErrorKey] = UnanticipatedErrorRecoveryAttempter(obsError: e)
        
        return NSError(domain: OBSError.Domain, code: e.code, userInfo: nil)
    }
}


/// Class usable as the NSRecoveryAttempterErrorKey object in an NSError that presents the 'Unexpected' error and gives the option of copying the full error to the pasteboard.
public class UnanticipatedErrorRecoveryAttempter: NSObject {
    /// Key used in NSError.userInfo dictionaries to store call stack addresses
    public static let ReturnAddressesKey = "CallStackReturnAddresses"
    
    /// Key used in NSError.userInfo dictionaries to store an OnDelete object that raises a fatal error if not cancelled
    public static let PreviousRecoverySuggestionKey = "PreviousRecoverySuggestion"
    
    private var obsError:OBSError
    
    init(obsError:OBSError) {
        self.obsError = obsError
    }
    /// There are two possible `attemptRecoveryFromError` methods. This one just feeds into the other.
    public override func attemptRecoveryFromError(error: NSError, optionIndex: Int, delegate: AnyObject?, didRecoverSelector: Selector, contextInfo: UnsafeMutablePointer<Void>) -> Void {
        self.attemptRecoveryFromError(error, optionIndex: optionIndex)
    }
    
    
    /// When a button is tapped, either close the dialog or copy the error details as appropriate.
    public override func attemptRecoveryFromError(error: NSError, optionIndex: Int) -> Bool {
        return obsError.attemptRecoveryFromError(error, optionIndex: optionIndex)
    }
}



public protocol ErrorPresenter {
    func presentError(error: NSError, _ completion: (() -> Void)?)
}

extension UIViewController: ErrorPresenter {
    /// An adapter function that allows the UnanticipatedErrorRecoveryAttempter to be used on iOS to present errors over a UIViewController.
    public func presentError(error: NSError, _ completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: error.localizedDescription, message: error.localizedRecoverySuggestion ?? error.localizedFailureReason, preferredStyle: UIAlertControllerStyle.Alert)
        
        if let ro = error.localizedRecoveryOptions, ra = error.recoveryAttempter as? UnanticipatedErrorRecoveryAttempter {
            for (index, option) in ro.enumerate() {
                alert.addAction(UIAlertAction(title: option, style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction?) -> Void in
                    ra.attemptRecoveryFromError(error, optionIndex: index)
                }))
            }
        }
        self.presentViewController(alert, animated: true, completion: completion)
    }
}

