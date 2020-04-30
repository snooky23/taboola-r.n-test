//
//  RNTaboolaView.h
//  RNTaboola
//
//  Created by Julian Gutierrez on 7/22/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <React/RCTComponent.h>
#import <WebKit/WebKit.h>
@interface RNTaboolaView : WKWebView
@property (nonatomic, copy) RCTBubblingEventBlock onOrganicItemClick;
@property (nonatomic, copy) RCTBubblingEventBlock onAdItemClick;
@property (nonatomic, copy) RCTBubblingEventBlock onDidLoad;
@property (nonatomic, copy) RCTBubblingEventBlock onDidFailToLoad;
@property(nonatomic, strong) NSString *publisher;
@property(nonatomic, strong) NSString *mode;
@property(nonatomic, strong) NSString *viewID;
@property(nonatomic, strong) NSString *placement;
@property(nonatomic, strong) NSString *pageType;
@property(nonatomic, strong) NSString *pageUrl;
@property(nonatomic, strong) NSString *targetType;
@property(nonatomic, readwrite) BOOL interceptScroll;
@property(nonatomic, readwrite) BOOL scrollEnabled;
@property(nonatomic, readwrite) BOOL autoResizeHeight;
- (void)fetchContent;
@end


