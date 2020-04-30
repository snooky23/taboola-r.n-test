//
//  RNTaboolaViewManager.h
//  Pods-taboolaSampleApp
//
//  Created by Julian Gutierrez on 7/21/18.
//

#if __has_include("RCTViewManager.h")
#import "RCTViewManager.h"
#else
#import <React/RCTViewManager.h>
#endif
#import <TaboolaSDK/TaboolaSDK.h>

@interface RNTaboolaViewManager : RCTViewManager <TaboolaJSDelegate>

@end

