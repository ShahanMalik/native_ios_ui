#!/bin/bash

# Script to fix common CocoaPods issues

echo "Running CocoaPods fix script..."

# Fix for iOS example app
if [ -d "example/ios" ]; then
  cd example/ios
  echo "Fixing CocoaPods in example/ios..."
  
  # Remove existing Pods directory if needed
  if [ -d "Pods" ]; then
    echo "Removing existing Pods directory..."
    rm -rf Pods
  fi
  
  # Make sure Podfile exists
  if [ ! -f "Podfile" ]; then
    echo "ERROR: Podfile doesn't exist. Creating a basic one..."
    cat > Podfile << EOF
# Uncomment this line to define a global platform for your project
platform :ios, '13.0'

# CocoaPods analytics sends network stats synchronously affecting flutter build latency.
ENV['COCOAPODS_DISABLE_STATS'] = 'true'

project 'Runner', {
  'Debug' => :debug,
  'Profile' => :release,
  'Release' => :release,
}

def flutter_root
  generated_xcode_build_settings_path = File.expand_path(File.join('..', 'Flutter', 'Generated.xcconfig'), __FILE__)
  unless File.exist?(generated_xcode_build_settings_path)
    raise "#{generated_xcode_build_settings_path} must exist. If you're running pod install manually, make sure flutter pub get is executed first"
  end

  File.foreach(generated_xcode_build_settings_path) do |line|
    matches = line.match(/FLUTTER_ROOT\=(.*)/)
    return matches[1].strip if matches
  end
  raise "FLUTTER_ROOT not found in #{generated_xcode_build_settings_path}. Try deleting Generated.xcconfig, then run flutter pub get"
end

require File.expand_path(File.join('packages', 'flutter_tools', 'bin', 'podhelper'), flutter_root)

flutter_ios_podfile_setup

target 'Runner' do
  use_frameworks!
  use_modular_headers!

  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
EOF
  fi
  
  # Run pod install with various options to help resolve common issues
  echo "Running pod install..."
  pod repo update
  pod install --verbose
  
  cd ../..
fi

# Fix for main iOS directory
if [ -d "ios" ]; then
  cd ios
  echo "Fixing CocoaPods in main ios directory..."
  
  # Make sure Podfile exists
  if [ ! -f "Podfile" ]; then
    echo "WARNING: No Podfile found in ios directory. Creating one..."
    cat > Podfile << EOF
# Uncomment this line to define a global platform for your project
platform :ios, '13.0'

# CocoaPods analytics sends network stats synchronously affecting flutter build latency.
ENV['COCOAPODS_DISABLE_STATS'] = 'true'

target 'native_ios_ui' do
  use_frameworks!
  use_modular_headers!
  
  # Include the native_ios_ui pod explicitly
  pod 'native_ios_ui', :path => './'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
EOF
  fi

  # Run pod install
  echo "Running pod install..."
  pod repo update
  pod install --verbose

  cd ..
fi

echo "CocoaPods fix script complete."
