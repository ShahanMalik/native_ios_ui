
import 'native_ios_ui_platform_interface.dart';

export 'native_ios_ui_platform_interface.dart' show TabBarItem;

class NativeIosUi {
  Future<String?> getPlatformVersion() {
    return NativeIosUiPlatform.instance.getPlatformVersion();
  }

  /// Creates a native iOS UITabBarController with the specified items
  Future<void> createTabBarController({
    required List<TabBarItem> items,
    int initialIndex = 0,
  }) {
    return NativeIosUiPlatform.instance.createTabBarController(
      items: items,
      initialIndex: initialIndex,
    );
  }

  /// Updates the tab bar items
  Future<void> updateTabBarItems(List<TabBarItem> items) {
    return NativeIosUiPlatform.instance.updateTabBarItems(items);
  }

  /// Sets the selected tab index
  Future<void> setSelectedIndex(int index) {
    return NativeIosUiPlatform.instance.setSelectedIndex(index);
  }

  /// Gets the currently selected tab index
  Future<int> getSelectedIndex() {
    return NativeIosUiPlatform.instance.getSelectedIndex();
  }

  /// Customizes the tab bar appearance
  Future<void> customizeTabBarAppearance({
    String? backgroundColor,
    String? selectedItemColor,
    String? unselectedItemColor,
    bool? translucent,
  }) {
    return NativeIosUiPlatform.instance.customizeTabBarAppearance(
      backgroundColor: backgroundColor,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
      translucent: translucent,
    );
  }
}
