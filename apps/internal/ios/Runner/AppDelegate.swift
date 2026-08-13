import AVKit
import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate, AudioOutputHostApi {
  private var carPlayHost: CarPlayCatalogHost?
  private var audioRoutePicker: AVRoutePickerView?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    let messenger = engineBridge.applicationRegistrar.messenger()
    let host = CarPlayCatalogHost(binaryMessenger: messenger)
    carPlayHost = host
    CarPlayHostApiSetup.setUp(binaryMessenger: messenger, api: host)
    AudioOutputHostApiSetup.setUp(binaryMessenger: messenger, api: self)
  }

  func showPicker() throws {
    guard let window = UIApplication.shared.connectedScenes
      .compactMap({ $0 as? UIWindowScene })
      .flatMap({ $0.windows })
      .first(where: { $0.isKeyWindow }) else {
      throw PigeonError(
        code: "no-window",
        message: "The audio output picker needs an active window.",
        details: nil
      )
    }

    let picker = AVRoutePickerView(frame: CGRect(
      x: window.bounds.midX,
      y: window.bounds.midY,
      width: 1,
      height: 1
    ))
    picker.prioritizesVideoDevices = false
    window.addSubview(picker)
    audioRoutePicker = picker

    guard let button = picker.subviews.compactMap({ $0 as? UIButton }).first else {
      picker.removeFromSuperview()
      audioRoutePicker = nil
      throw PigeonError(
        code: "picker-unavailable",
        message: "The system audio output picker is unavailable.",
        details: nil
      )
    }

    button.sendActions(for: .touchUpInside)
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
      picker.removeFromSuperview()
      if self?.audioRoutePicker === picker {
        self?.audioRoutePicker = nil
      }
    }
  }
}
