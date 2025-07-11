import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'native_ios_ui_method_channel.dart';

abstract class NativeIosUiPlatform extends PlatformInterface {
  /// Constructs a NativeIosUiPlatform.
  NativeIosUiPlatform() : super(token: _token);

  static final Object _token = Object();

  static NativeIosUiPlatform _instance = MethodChannelNativeIosUi();

  /// The default instance of [NativeIosUiPlatform] to use.
  ///
  /// Defaults to [MethodChannelNativeIosUi].
  static NativeIosUiPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NativeIosUiPlatform] when
  /// they register themselves.
  static set instance(NativeIosUiPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  /// Creates a native iOS UITabBarController
  Future<void> createTabBarController({
    required List<TabBarItem> items,
    int initialIndex = 0,
  }) {
    throw UnimplementedError('createTabBarController() has not been implemented.');
  }

  /// Updates the tab bar items
  Future<void> updateTabBarItems(List<TabBarItem> items) {
    throw UnimplementedError('updateTabBarItems() has not been implemented.');
  }

  /// Sets the selected tab index
  Future<void> setSelectedIndex(int index) {
    throw UnimplementedError('setSelectedIndex() has not been implemented.');
  }

  /// Gets the currently selected tab index
  Future<int> getSelectedIndex() {
    throw UnimplementedError('getSelectedIndex() has not been implemented.');
  }

  /// Customizes the tab bar appearance
  Future<void> customizeTabBarAppearance({
    String? backgroundColor,
    String? selectedItemColor,
    String? unselectedItemColor,
    bool? translucent,
  }) {
    throw UnimplementedError('customizeTabBarAppearance() has not been implemented.');
  }
}

/// Represents a tab bar item
class TabBarItem {
  final String title;
  final String? iconName;
  final String? selectedIconName;
  final int tag;

  TabBarItem({
    required this.title,
    this.iconName,
    this.selectedIconName,
    required this.tag,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'iconName': iconName,
      'selectedIconName': selectedIconName,
      'tag': tag,
    };
  }
}
