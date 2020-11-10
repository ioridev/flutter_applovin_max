#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_applovin_max.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_applovin_max'
  s.version          = '0.0.2'
  s.summary          = 'A new Flutter plugin.'
  s.description      = <<-DESC
A new Flutter plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'AppLovinSDK'
  s.dependency 'AppLovinMediationAdColonyAdapter'
  s.dependency 'AppLovinMediationFacebookAdapter'
  s.dependency 'AppLovinMediationInMobiAdapter'
  s.dependency 'AppLovinMediationByteDanceAdapter'
  s.dependency 'AppLovinMediationSmaatoAdapter'
  s.dependency 'AppLovinMediationTapjoyAdapter'
  s.dependency 'AppLovinMediationVerizonAdsAdapter'
  s.dependency 'AppLovinMediationVungleAdapter'
  s.dependency 'AppLovinMediationAmazonAdapter'
  s.dependency 'AppLovinMediationChartboostAdapter'
  s.dependency 'AppLovinMediationFyberAdapter'
  s.dependency 'AppLovinMediationGoogleAdapter'
  s.dependency 'AppLovinMediationGoogleAdManagerAdapter'
  s.dependency 'AppLovinMediationHyprMXAdapter'
  s.dependency 'AppLovinMediationIronSourceAdapter'
  s.dependency 'AppLovinMediationMaioAdapter'
  s.dependency 'AppLovinMediationMyTargetAdapter'
  s.dependency 'AppLovinMediationNendAdapter'
  s.dependency 'AppLovinMediationSnapAdapter'
  s.dependency 'AppLovinMediationTencentGDTAdapter'
  s.dependency 'AppLovinMediationUnityAdsAdapter'
  s.dependency 'AppLovinMediationYandexAdapter'

  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
