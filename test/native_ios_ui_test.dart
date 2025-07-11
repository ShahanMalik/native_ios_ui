import 'package:flutter_test/flutter_test.dart';
import 'package:native_ios_ui/native_ios_ui.dart';
import 'package:native_ios_ui/native_ios_ui_platform_interface.dart';
import 'package:native_ios_ui/native_ios_ui_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNativeIosUiPlatform
    with MockPlatformInterfaceMixin
    implements NativeIosUiPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> createTabBarController({
    required List<TabBarItem> items,
    int initialIndex = 0,
  }) async {
    // Mock implementation
  }

  @override
  Future<void> updateTabBarItems(List<TabBarItem> items) async {
    // Mock implementation
  }

  @override
  Future<void> setSelectedIndex(int index) async {
    // Mock implementation
  }

  @override
  Future<int> getSelectedIndex() async {
    return 0;
  }

  @override
  Future<void> customizeTabBarAppearance({
    String? backgroundColor,
    String? selectedItemColor,
    String? unselectedItemColor,
    bool? translucent,
  }) async {
    // Mock implementation
  }
}

void main() {
  final NativeIosUiPlatform initialPlatform = NativeIosUiPlatform.instance;

  test('$MethodChannelNativeIosUi is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNativeIosUi>());
  });

  test('getPlatformVersion', () async {
    NativeIosUi nativeIosUiPlugin = NativeIosUi();
    MockNativeIosUiPlatform fakePlatform = MockNativeIosUiPlatform();
    NativeIosUiPlatform.instance = fakePlatform;

    expect(await nativeIosUiPlugin.getPlatformVersion(), '42');
  });

  test('createTabBarController', () async {
    NativeIosUi nativeIosUiPlugin = NativeIosUi();
    MockNativeIosUiPlatform fakePlatform = MockNativeIosUiPlatform();
    NativeIosUiPlatform.instance = fakePlatform;

    final items = [
      TabBarItem(title: 'Home', tag: 0),
      TabBarItem(title: 'Profile', tag: 1),
    ];

    // Should not throw an exception
    await nativeIosUiPlugin.createTabBarController(items: items);
  });

  test('TabBarItem.toMap', () {
    final item = TabBarItem(
      title: 'Home',
      iconName: 'house',
      selectedIconName: 'house.fill',
      tag: 0,
    );

    final map = item.toMap();
    expect(map['title'], 'Home');
    expect(map['iconName'], 'house');
    expect(map['selectedIconName'], 'house.fill');
    expect(map['tag'], 0);
  });

  test('getSelectedIndex', () async {
    NativeIosUi nativeIosUiPlugin = NativeIosUi();
    MockNativeIosUiPlatform fakePlatform = MockNativeIosUiPlatform();
    NativeIosUiPlatform.instance = fakePlatform;

    expect(await nativeIosUiPlugin.getSelectedIndex(), 0);
  });
}
