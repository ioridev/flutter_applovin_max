#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run 'pod lib lint flutter_applovin_max.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_applovin_max'
  s.version          = '0.1.0'
  s.summary          = 'A new Flutter plugin.'
  s.description      = <<-DESC
A new Flutter plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'AppLovinSDK'
  s.static_framework = true
  s.platform = :ios, '9.0'
  s.swift_version = '5.0'
end
