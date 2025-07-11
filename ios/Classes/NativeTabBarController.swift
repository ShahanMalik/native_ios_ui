import UIKit
import Flutter

public class NativeTabBarController: UITabBarController {
    private var flutterChannel: FlutterMethodChannel?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }
    
    private func setupTabBarController() {
        delegate = self
        
        // Configure tab bar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
    
    public func setFlutterChannel(_ channel: FlutterMethodChannel) {
        self.flutterChannel = channel
    }
    
    // Create view controllers for each tab
    public func createViewControllers(from itemsData: [[String: Any]]) -> [UIViewController] {
        var viewControllers: [UIViewController] = []
        
        for (index, itemData) in itemsData.enumerated() {
            let title = itemData["title"] as? String ?? "Tab \(index + 1)"
            let tag = itemData["tag"] as? Int ?? index
            let iconName = itemData["iconName"] as? String
            let selectedIconName = itemData["selectedIconName"] as? String
            
            // Create a navigation controller for each tab
            let viewController = createTabViewController(
                title: title,
                tag: tag,
                iconName: iconName,
                selectedIconName: selectedIconName
            )
            
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.tabBarItem = viewController.tabBarItem
            
            viewControllers.append(navigationController)
        }
        
        return viewControllers
    }
    
    private func createTabViewController(
        title: String,
        tag: Int,
        iconName: String?,
        selectedIconName: String?
    ) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor.systemBackground
        viewController.title = title
        
        // Add some content to the view controller
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        viewController.view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor)
        ])
        
        // Configure tab bar item
        if let iconName = iconName {
            let image = UIImage(systemName: iconName)
            let selectedImage = selectedIconName != nil ? UIImage(systemName: selectedIconName!) : nil
            viewController.tabBarItem = UITabBarItem(
                title: title,
                image: image,
                selectedImage: selectedImage
            )
        } else {
            viewController.tabBarItem = UITabBarItem(
                title: title,
                image: nil,
                tag: tag
            )
        }
        
        viewController.tabBarItem.tag = tag
        
        return viewController
    }
}

// MARK: - UITabBarControllerDelegate
extension NativeTabBarController: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let selectedIndex = tabBarController.selectedIndex
        
        // Notify Flutter about tab selection change
        flutterChannel?.invokeMethod("onTabSelected", arguments: ["index": selectedIndex])
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // You can add custom logic here to prevent tab selection if needed
        return true
    }
}
