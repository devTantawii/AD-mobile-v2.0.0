import UIKit
import Flutter
import GoogleMaps
import FirebaseCore
import Firebase

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GMSServices.provideAPIKey("AIzaSyC4xQ0n-BwL_gODzdOTI6eqmzABT7XtF9Y")
    GeneratedPluginRegistrant.register(with: self)
    if #available(iOS 11.0, *){
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
          let firebaseAuth = Auth.auth()
          firebaseAuth.setAPNSToken(deviceToken, type: AuthAPNSTokenType.unknown)

      }
      override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
          let firebaseAuth = Auth.auth()
          if (firebaseAuth.canHandleNotification(userInfo)){
              print(userInfo)
              return
          }
      }
}