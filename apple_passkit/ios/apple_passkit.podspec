#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint apple_passkit.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'apple_passkit'
  s.version          = '0.0.1'
  s.summary          = 'Apple PassKit'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'apple_passkit/Sources/apple_passkit/**/*.swift'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'
  s.resource_bundles = {'apple_passkit_privacy' => ['apple_passkit/Sources/apple_passkit/PrivacyInfo.xcprivacy']}


  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
