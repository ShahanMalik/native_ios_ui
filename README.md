# native_ios_ui

A Flutter plugin that provides native iOS UITabBarController integration for Flutter apps.

## Features

- ✅ Create native iOS UITabBarController with custom tab items
- ✅ Customize tab bar appearance (colors, translucency)
- ✅ Programmatically control tab selection
- ✅ Update tab bar items dynamically
- ✅ Use SF Symbols for tab icons
- ✅ Full iOS native look and feel

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  native_ios_ui: ^0.0.1
```

## Usage

### Basic Setup

```dart
import 'package:native_ios_ui/native_ios_ui.dart';

final nativeIosUi = NativeIosUi();
```

### Creating a Tab Bar Controller

```dart
// Define your tab items
final items = [
  TabBarItem(
    title: 'Home',
    iconName: 'house',           // SF Symbol name
    selectedIconName: 'house.fill', // SF Symbol for selected state
    tag: 0,
  ),
  TabBarItem(
    title: 'Search',
    iconName: 'magnifyingglass',
    selectedIconName: 'magnifyingglass.circle.fill',
    tag: 1,
  ),
  TabBarItem(
    title: 'Profile',
    iconName: 'person',
    selectedIconName: 'person.fill',
    tag: 2,
  ),
];

// Create the tab bar controller
await nativeIosUi.createTabBarController(
  items: items,
  initialIndex: 0, // Start with the first tab selected
);
```

### Customizing Tab Bar Appearance

```dart
await nativeIosUi.customizeTabBarAppearance(
  backgroundColor: '#F8F9FA',      // Hex color code
  selectedItemColor: '#007AFF',    // iOS blue
  unselectedItemColor: '#8E8E93',  // iOS gray
  translucent: false,
);
```

### Controlling Tab Selection

```dart
// Set selected tab programmatically
await nativeIosUi.setSelectedIndex(1);

// Get current selected tab index
int selectedIndex = await nativeIosUi.getSelectedIndex();
```

### Updating Tab Items

```dart
final newItems = [
  TabBarItem(
    title: 'Updated',
    iconName: 'star',
    selectedIconName: 'star.fill',
    tag: 0,
  ),
  TabBarItem(
    title: 'New Tab',
    iconName: 'plus',
    selectedIconName: 'plus.circle.fill',
    tag: 1,
  ),
];

await nativeIosUi.updateTabBarItems(newItems);
```

## API Reference

### NativeIosUi

#### Methods

- `createTabBarController({required List<TabBarItem> items, int initialIndex = 0})` - Creates a native iOS UITabBarController
- `updateTabBarItems(List<TabBarItem> items)` - Updates the tab bar items
- `setSelectedIndex(int index)` - Sets the selected tab index
- `getSelectedIndex()` - Gets the currently selected tab index
- `customizeTabBarAppearance({...})` - Customizes the tab bar appearance

### TabBarItem

#### Properties

- `title` (String) - The title of the tab
- `iconName` (String?) - SF Symbol name for the tab icon
- `selectedIconName` (String?) - SF Symbol name for the selected state icon
- `tag` (int) - Unique identifier for the tab

### Customization Options

#### customizeTabBarAppearance

- `backgroundColor` (String?) - Hex color code for background
- `selectedItemColor` (String?) - Hex color code for selected items
- `unselectedItemColor` (String?) - Hex color code for unselected items
- `translucent` (bool?) - Whether the tab bar should be translucent

## SF Symbols

This plugin uses SF Symbols for tab icons. Here are some commonly used symbols:

- `house` / `house.fill` - Home
- `magnifyingglass` / `magnifyingglass.circle.fill` - Search
- `person` / `person.fill` - Profile
- `gearshape` / `gearshape.fill` - Settings
- `star` / `star.fill` - Favorites
- `message` / `message.fill` - Messages
- `plus` / `plus.circle.fill` - Add
- `ellipsis` / `ellipsis.circle.fill` - More

For a complete list of SF Symbols, visit: https://developer.apple.com/sf-symbols/

## Example

Check the `example` folder for a complete working example that demonstrates all features of the plugin.

## Platform Support

- ✅ iOS
- ❌ Android (iOS-specific functionality)

## Requirements

- iOS 13.0 or later
- Flutter 3.3.0 or later

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.i

A new Flutter plugin project.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/to/develop-plugins),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

