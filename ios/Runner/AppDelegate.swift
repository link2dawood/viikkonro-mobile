import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  private let routesChannelName = "fi.viikkonro.app/routes"
  private var routesChannel: FlutterMethodChannel?
  private var pendingRoute: String?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if let url = launchOptions?[.url] as? URL {
      pendingRoute = route(from: url)
    }
    if let controller = window?.rootViewController as? FlutterViewController {
      routesChannel = FlutterMethodChannel(name: routesChannelName, binaryMessenger: controller.binaryMessenger)
      routesChannel?.setMethodCallHandler { [weak self] call, result in
        guard call.method == "initialRoute" else {
          result(FlutterMethodNotImplemented)
          return
        }
        result(self?.pendingRoute)
        self?.pendingRoute = nil
      }
    }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey: Any] = [:]
  ) -> Bool {
    guard let target = route(from: url) else {
      return super.application(app, open: url, options: options)
    }
    if let channel = routesChannel {
      channel.invokeMethod("route", arguments: target)
    } else {
      pendingRoute = target
    }
    return true
  }

  private func route(from url: URL) -> String? {
    guard url.scheme == "viikkonro", url.host == "widget", !url.path.isEmpty else { return nil }
    return url.path + (url.query.map { "?\($0)" } ?? "")
  }
}
