import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'native_ios_ui_platform_interface.dart';

/// An implementation of [NativeIosUiPlatform] that uses method channels.
class MethodChannelNativeIosUi extends NativeIosUiPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('native_ios_ui');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> createTabBarController({
    required List<TabBarItem> items,
    int initialIndex = 0,
  }) async {
    await methodChannel.invokeMethod('createTabBarController', {
      'items': items.map((item) => item.toMap()).toList(),
      'initialIndex': initialIndex,
    });
  }

  @override
  Future<void> updateTabBarItems(List<TabBarItem> items) async {
    await methodChannel.invokeMethod('updateTabBarItems', {
      'items': items.map((item) => item.toMap()).toList(),
    });
  }

  @override
  Future<void> setSelectedIndex(int index) async {
    await methodChannel.invokeMethod('setSelectedIndex', {
      'index': index,
    });
  }

  @override
  Future<int> getSelectedIndex() async {
    final index = await methodChannel.invokeMethod<int>('getSelectedIndex');
    return index ?? 0;
  }

  @override
  Future<void> customizeTabBarAppearance({
    String? backgroundColor,
    String? selectedItemColor,
    String? unselectedItemColor,
    bool? translucent,
  }) async {
    await methodChannel.invokeMethod('customizeTabBarAppearance', {
      'backgroundColor': backgroundColor,
      'selectedItemColor': selectedItemColor,
      'unselectedItemColor': unselectedItemColor,
      'translucent': translucent,
    });
  }
}
