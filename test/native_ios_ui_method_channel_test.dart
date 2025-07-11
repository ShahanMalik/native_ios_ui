import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:native_ios_ui/native_ios_ui_method_channel.dart';
import 'package:native_ios_ui/native_ios_ui_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelNativeIosUi platform = MethodChannelNativeIosUi();
  const MethodChannel channel = MethodChannel('native_ios_ui');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'getPlatformVersion':
            return '42';
          case 'createTabBarController':
            return null;
          case 'updateTabBarItems':
            return null;
          case 'setSelectedIndex':
            return null;
          case 'getSelectedIndex':
            return 0;
          case 'customizeTabBarAppearance':
            return null;
          default:
            return null;
        }
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });

  test('createTabBarController', () async {
    final items = [
      TabBarItem(title: 'Home', tag: 0),
      TabBarItem(title: 'Profile', tag: 1),
    ];

    // Should not throw an exception
    await platform.createTabBarController(items: items);
  });

  test('getSelectedIndex', () async {
    expect(await platform.getSelectedIndex(), 0);
  });

  test('setSelectedIndex', () async {
    // Should not throw an exception
    await platform.setSelectedIndex(1);
  });

  test('updateTabBarItems', () async {
    final items = [
      TabBarItem(title: 'Updated', tag: 0),
    ];

    // Should not throw an exception
    await platform.updateTabBarItems(items);
  });

  test('customizeTabBarAppearance', () async {
    // Should not throw an exception
    await platform.customizeTabBarAppearance(
      backgroundColor: '#FFFFFF',
      selectedItemColor: '#007AFF',
      unselectedItemColor: '#8E8E93',
      translucent: false,
    );
  });
}
