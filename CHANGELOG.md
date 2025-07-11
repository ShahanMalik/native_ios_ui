## 0.0.3

* Fixed UI overflow issues in example app
* Improved responsive layout with LayoutBuilder
* Enhanced SafeArea and SingleChildScrollView implementation
* Fixed code structure and syntax issues
* Improved stability for different screen sizes
* Updated documentation

## 0.0.2

* Updated podspec with proper metadata
* Added comprehensive .gitignore
* Added GitHub Actions CI/CD pipeline
* Added community templates (issues, PRs, contributing)
* Enhanced documentation with badges
* Improved package structure

## 0.0.2

### Improvements
- ✅ **Added Podfile** for iOS integration and CI/CD compatibility
- ✅ **Updated podspec** with proper metadata
- ✅ **Fixed build issues** on CI/CD platforms like Codemagic
- ✅ **Improved documentation** for clearer setup instructions
- ✅ **Enhanced iOS compatibility** with explicit dependency management

## 0.0.1

### Features
- ✅ **Native iOS UITabBarController Integration**: Create and manage native iOS tab bar controllers from Flutter
- ✅ **SF Symbols Support**: Use SF Symbols for tab icons with selected/unselected states
- ✅ **Tab Bar Customization**: Customize colors, translucency, and appearance
- ✅ **Programmatic Control**: Set and get selected tab index programmatically
- ✅ **Dynamic Updates**: Update tab bar items dynamically at runtime
- ✅ **Smooth Transitions**: Native iOS animations and transitions
- ✅ **Navigation Controller Integration**: Each tab gets its own navigation controller
- ✅ **Comprehensive Example**: Full example app demonstrating all features

### API
- `createTabBarController()` - Creates a native iOS UITabBarController
- `updateTabBarItems()` - Updates tab bar items dynamically
- `setSelectedIndex()` - Sets the selected tab index
- `getSelectedIndex()` - Gets the currently selected tab index
- `customizeTabBarAppearance()` - Customizes tab bar appearance
- `TabBarItem` class for defining tab items with SF Symbols

### Requirements
- iOS 13.0+
- Flutter 3.3.0+
- Xcode 12.0+

### Example Usage
```dart
final items = [
  TabBarItem(
    title: 'Home',
    iconName: 'house',
    selectedIconName: 'house.fill',
    tag: 0,
  ),
];

await nativeIosUi.createTabBarController(items: items);
```

### Platform Support
- ✅ iOS (Native UITabBarController)
- ❌ Android (iOS-specific functionality)
