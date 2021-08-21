#import "FlutterApplovinMaxPlugin.h"
#if __has_include(<flutter_applovin_max/flutter_applovin_max-Swift.h>)
#import <flutter_applovin_max/flutter_applovin_max-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_applovin_max-Swift.h"
#endif

@implementation FlutterApplovinMaxPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterApplovinMaxPlugin registerWithRegistrar:registrar];
}
@end