# Advanced Usage Examples

## Custom Tab Bar with Navigation

```dart
import 'package:native_ios_ui/native_ios_ui.dart';

class TabBarExample extends StatefulWidget {
  @override
  _TabBarExampleState createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<TabBarExample> {
  final NativeIosUi _nativeIosUi = NativeIosUi();
  
  @override
  void initState() {
    super.initState();
    _setupTabBar();
  }
  
  Future<void> _setupTabBar() async {
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
        title: 'Favorites',
        iconName: 'star',
        selectedIconName: 'star.fill',
        tag: 2,
      ),
      TabBarItem(
        title: 'Profile',
        iconName: 'person',
        selectedIconName: 'person.fill',
        tag: 3,
      ),
    ];
    
    // Create tab bar
    await _nativeIosUi.createTabBarController(
      items: items,
      initialIndex: 0,
    );
    
    // Customize appearance
    await _nativeIosUi.customizeTabBarAppearance(
      backgroundColor: '#FFFFFF',
      selectedItemColor: '#007AFF',
      unselectedItemColor: '#8E8E93',
      translucent: false,
    );
  }
}
```

## Dynamic Tab Management

```dart
class DynamicTabBarExample extends StatefulWidget {
  @override
  _DynamicTabBarExampleState createState() => _DynamicTabBarExampleState();
}

class _DynamicTabBarExampleState extends State<DynamicTabBarExample> {
  final NativeIosUi _nativeIosUi = NativeIosUi();
  List<TabBarItem> _currentItems = [];
  
  void _addTab() async {
    final newItem = TabBarItem(
      title: 'New Tab ${_currentItems.length + 1}',
      iconName: 'plus.circle',
      selectedIconName: 'plus.circle.fill',
      tag: _currentItems.length,
    );
    
    _currentItems.add(newItem);
    await _nativeIosUi.updateTabBarItems(_currentItems);
  }
  
  void _removeTab() async {
    if (_currentItems.isNotEmpty) {
      _currentItems.removeLast();
      await _nativeIosUi.updateTabBarItems(_currentItems);
    }
  }
  
  void _switchToTab(int index) async {
    if (index >= 0 && index < _currentItems.length) {
      await _nativeIosUi.setSelectedIndex(index);
    }
  }
  
  void _getCurrentTab() async {
    final index = await _nativeIosUi.getSelectedIndex();
    print('Current tab index: $index');
  }
}
```

## Theme-based Customization

```dart
class ThemedTabBarExample {
  final NativeIosUi _nativeIosUi = NativeIosUi();
  
  Future<void> _applyLightTheme() async {
    await _nativeIosUi.customizeTabBarAppearance(
      backgroundColor: '#FFFFFF',
      selectedItemColor: '#007AFF',
      unselectedItemColor: '#8E8E93',
      translucent: false,
    );
  }
  
  Future<void> _applyDarkTheme() async {
    await _nativeIosUi.customizeTabBarAppearance(
      backgroundColor: '#000000',
      selectedItemColor: '#0A84FF',
      unselectedItemColor: '#8E8E93',
      translucent: false,
    );
  }
  
  Future<void> _applyCustomTheme() async {
    await _nativeIosUi.customizeTabBarAppearance(
      backgroundColor: '#F8F9FA',
      selectedItemColor: '#28A745',
      unselectedItemColor: '#6C757D',
      translucent: true,
    );
  }
}
```

## Common SF Symbols

Here are some commonly used SF Symbols for tab bars:

### Navigation
- `house` / `house.fill` - Home
- `magnifyingglass` / `magnifyingglass.circle.fill` - Search
- `arrow.left` / `arrow.left.circle.fill` - Back
- `arrow.right` / `arrow.right.circle.fill` - Forward

### Social & Communication
- `message` / `message.fill` - Messages
- `phone` / `phone.fill` - Phone
- `envelope` / `envelope.fill` - Email
- `person` / `person.fill` - Profile
- `person.2` / `person.2.fill` - Contacts

### Media & Entertainment
- `play` / `play.fill` - Play
- `music.note` / `music.note.house.fill` - Music
- `camera` / `camera.fill` - Camera
- `photo` / `photo.fill` - Photos
- `video` / `video.fill` - Video

### Utility
- `gearshape` / `gearshape.fill` - Settings
- `star` / `star.fill` - Favorites
- `bookmark` / `bookmark.fill` - Bookmarks
- `heart` / `heart.fill` - Likes
- `plus` / `plus.circle.fill` - Add
- `ellipsis` / `ellipsis.circle.fill` - More

### Business & Productivity
- `folder` / `folder.fill` - Files
- `doc` / `doc.fill` - Documents
- `calendar` / `calendar.today.fill` - Calendar
- `clock` / `clock.fill` - Time
- `chart.bar` / `chart.bar.fill` - Analytics

## Best Practices

1. **Consistent Icon Style**: Use either outline or filled icons consistently
2. **Meaningful Labels**: Keep tab titles short and descriptive
3. **Logical Order**: Arrange tabs in order of importance or usage frequency
4. **Accessibility**: SF Symbols automatically support accessibility features
5. **Testing**: Test on different iOS versions and device sizes

## Error Handling

```dart
try {
  await _nativeIosUi.createTabBarController(items: items);
} catch (e) {
  print('Error creating tab bar: $e');
  // Handle error appropriately
}
```

## Performance Tips

1. **Lazy Loading**: Only create view controllers when needed
2. **Memory Management**: Avoid holding references to large objects
3. **Efficient Updates**: Batch tab bar updates when possible
4. **Native Performance**: The plugin uses native iOS controllers for optimal performance
