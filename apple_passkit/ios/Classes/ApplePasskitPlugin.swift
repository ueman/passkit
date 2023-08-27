import Flutter
import UIKit
import PassKit

public class ApplePasskitPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "apple_passkit", binaryMessenger: registrar.messenger())
    let instance = ApplePasskitPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      switch call.method {
      case "isPassLibraryAvailable":
          isPassLibaryAvailable(result)
      case "canAddPasses":
          canAddPasses(result)
      case "addPasses":
          addPassesWithoutFlow(call, result)
      case "addPassesViewController":
          addPassFlow(call, result)
      case "addPassViewController":
          addPassFlow(call, result)
      case "getPasses":
          getPasses(result)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
    
    private func isPassLibaryAvailable(_ result: @escaping FlutterResult) {
      result(PKPassLibrary.isPassLibraryAvailable())
    }
    
    private func canAddPasses(_ result: @escaping FlutterResult) {
      result(PKAddPassesViewController.canAddPasses())
    }
    
    private func getPasses(_ result: @escaping FlutterResult) {
        let passNames = PKPassLibrary().passes().map {
            return $0.localizedName
        }
        result(passNames)
    }
    
    private func addPassFlow(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let pkPass = pkPassFromData(call, result: result)
        guard let pkPass else {
            result(ErrorCodes.empty)
            return
        }
        let vc = PKAddPassesViewController(pass: pkPass)!
        let delegate = PassKitDelegate(result)
        vc.delegate = delegate
        present(vc)
    }
    
    private func addPassesFlow(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let pkPasses = pkPassesFromData(call, result: result)
        guard let pkPasses else {
            result(ErrorCodes.empty)
            return
        }
        let vc = PKAddPassesViewController(passes: pkPasses)!
        let delegate = PassKitDelegate(result)
        vc.delegate = delegate
        present(vc)
    }
    
    private func addPassesWithoutFlow(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let pkPasses = pkPassesFromData(call, result: result)
        guard let pkPasses else {
            result(ErrorCodes.empty)
            return
        }
        PKPassLibrary().addPasses(pkPasses) {
            result(String(describing: $0))
        }
    }
    
    private func present(_ passViewController: UIViewController) {
        // TODO https://github.com/flutter/flutter/issues/104117
        let vc = UIApplication.shared.windows.first!.rootViewController!
        vc.present(passViewController, animated: true)
    }
    
    private func pkPassFromData(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> PKPass? {
        guard
            let arguments = call.arguments as? [Any],
            !arguments.isEmpty,
            let data = (arguments.first as? FlutterStandardTypedData)?.data
        else {
            result(ErrorCodes.empty)
            return nil
        }
        do {
            return try PKPass(data: data)
        } catch {
            result(ErrorCodes.invalidData)
            return nil
        }
        
    }
    
    private func pkPassesFromData(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> [PKPass]? {
        guard
            let arguments = call.arguments as? [Any],
            !arguments.isEmpty
        else {
            result(ErrorCodes.empty)
            return nil
        }
        // todo catch exception, notify Flutter via FlutterError
        return arguments.compactMap{
            let data = ($0 as? FlutterStandardTypedData)?.data
            guard let data else {
              return nil
            }
            return try? PKPass(data: data)
        }
        .filter { $0 != nil }
        .compactMap{ $0 }
    }
}

class PassKitDelegate : NSObject, PKAddPassesViewControllerDelegate {
    
    let result: FlutterResult
    
    init(_ result: @escaping FlutterResult){
        self.result = result
    }
    
    public func addPassesViewControllerDidFinish(_ vc: PKAddPassesViewController) {
        result(nil)
    }
}

enum ErrorCodes {
    static let empty = FlutterError(code: "empty", message: "Received data for PKPass was empty", details: nil)
    static let invalidData = FlutterError(code: "invalid", message: "Received data is not a valid PKPass", details: nil)
}
