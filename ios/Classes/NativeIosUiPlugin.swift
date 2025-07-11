import Flutter
import UIKit

public class NativeIosUiPlugin: NSObject, FlutterPlugin {
    private var tabBarController: NativeTabBarController?
    private var methodChannel: FlutterMethodChannel?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "native_ios_ui", binaryMessenger: registrar.messenger())
        let instance = NativeIosUiPlugin()
        instance.methodChannel = channel
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "createTabBarController":
            handleCreateTabBarController(call, result: result)
        case "updateTabBarItems":
            handleUpdateTabBarItems(call, result: result)
        case "setSelectedIndex":
            handleSetSelectedIndex(call, result: result)
        case "getSelectedIndex":
            handleGetSelectedIndex(result)
        case "customizeTabBarAppearance":
            handleCustomizeTabBarAppearance(call, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func handleCreateTabBarController(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any],
              let itemsData = args["items"] as? [[String: Any]],
              let initialIndex = args["initialIndex"] as? Int else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments for createTabBarController", details: nil))
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.createTabBarController(itemsData: itemsData, initialIndex: initialIndex)
            result(nil)
        }
    }
    
    private func createTabBarController(itemsData: [[String: Any]], initialIndex: Int) {
        let tabBarController = NativeTabBarController()
        
        // Set up the method channel for communication
        if let methodChannel = self.methodChannel {
            tabBarController.setFlutterChannel(methodChannel)
        }
        
        // Create view controllers
        let viewControllers = tabBarController.createViewControllers(from: itemsData)
        tabBarController.viewControllers = viewControllers
        tabBarController.selectedIndex = min(initialIndex, viewControllers.count - 1)
        
        self.tabBarController = tabBarController
        
        // Present the tab bar controller
        presentTabBarController(tabBarController)
    }
    
    private func presentTabBarController(_ tabBarController: UITabBarController) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            
            // Create a smooth transition
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window.rootViewController = tabBarController
            }, completion: nil)
            
            window.makeKeyAndVisible()
        }
    }
    
    private func handleUpdateTabBarItems(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any],
              let itemsData = args["items"] as? [[String: Any]] else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments for updateTabBarItems", details: nil))
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.updateTabBarItems(itemsData: itemsData)
            result(nil)
        }
    }
    
    private func updateTabBarItems(itemsData: [[String: Any]]) {
        guard let tabBarController = self.tabBarController else {
            return
        }
        
        let viewControllers = tabBarController.createViewControllers(from: itemsData)
        tabBarController.viewControllers = viewControllers
    }
    
    private func handleSetSelectedIndex(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any],
              let index = args["index"] as? Int else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments for setSelectedIndex", details: nil))
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let tabBarController = self?.tabBarController,
                  let viewControllers = tabBarController.viewControllers,
                  index >= 0 && index < viewControllers.count else {
                result(FlutterError(code: "INVALID_INDEX", message: "Invalid tab index", details: nil))
                return
            }
            
            tabBarController.selectedIndex = index
            result(nil)
        }
    }
    
    private func handleGetSelectedIndex(_ result: @escaping FlutterResult) {
        DispatchQueue.main.async { [weak self] in
            let selectedIndex = self?.tabBarController?.selectedIndex ?? 0
            result(selectedIndex)
        }
    }
    
    private func handleCustomizeTabBarAppearance(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any] else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments for customizeTabBarAppearance", details: nil))
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.customizeTabBarAppearance(args: args)
            result(nil)
        }
    }
    
    private func customizeTabBarAppearance(args: [String: Any]) {
        guard let tabBarController = self.tabBarController else {
            return
        }
        
        let tabBar = tabBarController.tabBar
        let appearance = UITabBarAppearance()
        
        // Configure with default background first
        appearance.configureWithDefaultBackground()
        
        // Set background color
        if let backgroundColorHex = args["backgroundColor"] as? String {
            appearance.backgroundColor = UIColor(hex: backgroundColorHex)
        }
        
        // Set selected item color
        if let selectedColorHex = args["selectedItemColor"] as? String {
            let selectedColor = UIColor(hex: selectedColorHex)
            appearance.stackedLayoutAppearance.selected.iconColor = selectedColor
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: selectedColor
            ]
            appearance.inlineLayoutAppearance.selected.iconColor = selectedColor
            appearance.inlineLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: selectedColor
            ]
            appearance.compactInlineLayoutAppearance.selected.iconColor = selectedColor
            appearance.compactInlineLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: selectedColor
            ]
        }
        
        // Set unselected item color
        if let unselectedColorHex = args["unselectedItemColor"] as? String {
            let unselectedColor = UIColor(hex: unselectedColorHex)
            appearance.stackedLayoutAppearance.normal.iconColor = unselectedColor
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: unselectedColor
            ]
            appearance.inlineLayoutAppearance.normal.iconColor = unselectedColor
            appearance.inlineLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: unselectedColor
            ]
            appearance.compactInlineLayoutAppearance.normal.iconColor = unselectedColor
            appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: unselectedColor
            ]
        }
        
        // Set translucent
        if let translucent = args["translucent"] as? Bool {
            tabBar.isTranslucent = translucent
        }
        
        // Apply the appearance
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}

// MARK: - UIColor Extension
extension UIColor {
    convenience init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6 {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
            return
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
}
