#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint native_ios_ui.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'native_ios_ui'
  s.version          = '0.0.3'
  s.summary          = 'A Flutter plugin that provides native iOS UITabBarController integration.'
  s.description      = <<-DESC
A Flutter plugin that provides native iOS UITabBarController integration for Flutter apps.
Create native iOS tab bars with SF Symbols support, customizable appearance, and full programmatic control.
                       DESC
  s.homepage         = 'https://github.com/ShahanMalik/native_ios_ui'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'ShahanMalik' => 'shahanmalikkhan@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'native_ios_ui_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end
