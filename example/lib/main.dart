import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:native_ios_ui/native_ios_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _nativeIosUiPlugin = NativeIosUi();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _nativeIosUiPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> _createBasicTabBar() async {
    final items = [
      TabBarItem(
        title: 'Home',
        iconName: 'house',
        selectedIconName: 'house.fill',
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

    await _nativeIosUiPlugin.createTabBarController(
      items: items,
      initialIndex: 0,
    );
  }

  Future<void> _createCustomTabBar() async {
    final items = [
      TabBarItem(
        title: 'Dashboard',
        iconName: 'chart.bar',
        selectedIconName: 'chart.bar.fill',
        tag: 0,
      ),
      TabBarItem(
        title: 'Messages',
        iconName: 'message',
        selectedIconName: 'message.fill',
        tag: 1,
      ),
      TabBarItem(
        title: 'Settings',
        iconName: 'gearshape',
        selectedIconName: 'gearshape.fill',
        tag: 2,
      ),
      TabBarItem(
        title: 'More',
        iconName: 'ellipsis',
        selectedIconName: 'ellipsis.circle.fill',
        tag: 3,
      ),
    ];

    await _nativeIosUiPlugin.createTabBarController(
      items: items,
      initialIndex: 1,
    );

    // Customize appearance
    await _nativeIosUiPlugin.customizeTabBarAppearance(
      backgroundColor: '#F8F9FA',
      selectedItemColor: '#007AFF',
      unselectedItemColor: '#8E8E93',
      translucent: false,
    );
  }

  Future<void> _updateTabBarItems() async {
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

    await _nativeIosUiPlugin.updateTabBarItems(newItems);
  }

  Future<void> _setSelectedIndex(int index) async {
    await _nativeIosUiPlugin.setSelectedIndex(index);
  }

  Future<void> _getSelectedIndex() async {
    final index = await _nativeIosUiPlugin.getSelectedIndex();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected index: $index')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native iOS UI Example'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Platform Information',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          Text('Running on: $_platformVersion'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tab Bar Controller',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _createBasicTabBar,
                            child: const Text('Create Basic Tab Bar'),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: _createCustomTabBar,
                            child: const Text('Create Custom Tab Bar'),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: _updateTabBarItems,
                            child: const Text('Update Tab Bar Items'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tab Bar Control',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 16),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              // Use column layout for small screens
                              if (constraints.maxWidth < 350) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => _setSelectedIndex(0),
                                      child: const Text('Select Tab 0'),
                                    ),
                                    const SizedBox(height: 8),
                                    ElevatedButton(
                                      onPressed: () => _setSelectedIndex(1),
                                      child: const Text('Select Tab 1'),
                                    ),
                                    const SizedBox(height: 8),
                                    ElevatedButton(
                                      onPressed: () => _setSelectedIndex(2),
                                      child: const Text('Select Tab 2'),
                                    ),
                                    const SizedBox(height: 8),
                                    ElevatedButton(
                                      onPressed: _getSelectedIndex,
                                      child: const Text('Get Selected'),
                                    ),
                                  ],
                                );
                              } else {
                                // Use row layout for larger screens
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () => _setSelectedIndex(0),
                                            child: const Text('Select Tab 0'),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () => _setSelectedIndex(1),
                                            child: const Text('Select Tab 1'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () => _setSelectedIndex(2),
                                            child: const Text('Select Tab 2'),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: _getSelectedIndex,
                                            child: const Text('Get Selected'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Usage Instructions',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '1. Tap "Create Basic Tab Bar" to create a simple tab bar\n'
                            '2. Tap "Create Custom Tab Bar" for a styled version\n'
                            '3. Use the control buttons to interact with the tab bar\n'
                            '4. The tab bar will replace the current view',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
