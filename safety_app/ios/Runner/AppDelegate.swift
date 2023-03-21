import UIKit
import CoreMotion
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {   
    GeneratedPluginRegistrant.register(with: self)
    UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60)) 
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let batteryChannel = FlutterMethodChannel(name: "samples.flutter.dev/battery",
                                              binaryMessenger: controller.binaryMessenger)
    batteryChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      // This method is invoked on the UI thread.
      // Handle battery messages.
      guard call.method == "getBatteryLevel" else {
        result(FlutterMethodNotImplemented)
        return
      }
      self.getSensorData(result: result)
    })
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  private func receiveBatteryLevel(result: FlutterResult) {
    let device = UIDevice.current
    device.isBatteryMonitoringEnabled = true
    if device.batteryState == UIDevice.BatteryState.unknown {
      result(FlutterError(code: "UNAVAILABLE",
                          message: "Battery level not available.",
                          details: nil))
    } else {
      result(Int(device.batteryLevel * 100))
    }
  }

  private func getSensorData(result: @escaping FlutterResult) {
    // Get live data from the accelerometer
    let motionManager = CMMotionManager()

    // Set the update interval to 1 second
    motionManager.accelerometerUpdateInterval = 1.0
    // Start the accelerometer
    motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
        // Check if data is not nil
        if let mydata = data {
            // Get the user acceleration data from the motion manager
            let x = mydata.acceleration.x
            let y = mydata.acceleration.y
            let z = mydata.acceleration.z
            // Print the acceleration values
            print("x = \(x)")
            print("y = \(y)")
            print("z = \(z)")
        }
    }
    
    result("Hello")
  }

}
