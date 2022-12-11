/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Main application delegate.
*/

import UIKit
import AuthenticationServices

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    /// - Tag: did_finish_launching
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        print("currentID:\(KeychainItem.currentUserIdentifier)")
        appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                print("登录状态有效")
                break // The Apple ID credential is valid.
            
//            case .revoked:
//                print("登录凭证已移出")
//                break
//            case .notFound:
//                print("未授权")
//                break;
                
                
            case .revoked, .notFound:
                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
                DispatchQueue.main.async {
                    self.window?.rootViewController?.showLoginViewController()
                }
            
            default:
                break
            }
        }
        return true
    }
}
