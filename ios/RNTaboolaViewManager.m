
//  RNTaboolaViewManager.m
//
//  Created by Julian Gutierrez on 7/21/18.
//

#import "RNTaboolaViewManager.h"
#import "RNTaboolaView.h"
#import <WebKit/WebKit.h>
#import <TaboolaSDK/TaboolaSDK.h>

@interface RNTaboolaViewManager ()
    @property(nonatomic, strong) RNTaboolaView * taboolaView;
    @property NSMutableArray* taboolas;
    @property(nonatomic, strong) UIViewController * fakeVC;
    @end

    @implementation RNTaboolaViewManager
RCT_EXPORT_MODULE()
NSString * const RN_VERSION = @"RN_1.2.6.A";
RCT_EXPORT_VIEW_PROPERTY(onOrganicItemClick, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onAdItemClick, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onDidLoad, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onDidFailToLoad, RCTBubblingEventBlock)

RCT_CUSTOM_VIEW_PROPERTY(mode, NSString* ,RNTaboolaView){
  view.mode = [RCTConvert NSString:json];
}
RCT_CUSTOM_VIEW_PROPERTY(viewID, NSString* ,RNTaboolaView){
  view.viewID = [RCTConvert NSString:json];
}
RCT_CUSTOM_VIEW_PROPERTY(publisher, NSString*, RNTaboolaView) {
  view.publisher = [RCTConvert NSString:json];
}
RCT_CUSTOM_VIEW_PROPERTY(pageType, NSString*, RNTaboolaView) {
  view.pageType = [RCTConvert NSString:json];
}
RCT_CUSTOM_VIEW_PROPERTY(pageUrl, NSString*, RNTaboolaView) {
  view.pageUrl = [RCTConvert NSString:json];
}
RCT_CUSTOM_VIEW_PROPERTY(placement, NSString*, RNTaboolaView) {
  view.placement = [RCTConvert NSString:json];
}
RCT_CUSTOM_VIEW_PROPERTY(targetType, NSString*, RNTaboolaView) {
  view.targetType = [RCTConvert NSString:json];
}
RCT_CUSTOM_VIEW_PROPERTY(scrollEnabled, BOOL ,RNTaboolaView){
  view.scrollEnabled = [RCTConvert BOOL:json];
}
RCT_CUSTOM_VIEW_PROPERTY(interceptScroll, BOOL ,RNTaboolaView){
  view.interceptScroll = [RCTConvert BOOL:json];
}
RCT_CUSTOM_VIEW_PROPERTY(autoResizeHeight, BOOL ,RNTaboolaView){
  view.autoResizeHeight = [RCTConvert BOOL:json];
}


- (UIView *)view {

WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];

[config setAllowsInlineMediaPlayback:YES];

RNTaboolaView* taboolaView = [[RNTaboolaView alloc] initWithFrame:CGRectZero configuration:config];

[[TaboolaJS sharedInstance] registerWebView:taboolaView];
[TaboolaJS sharedInstance].delegate = self ;
[[TaboolaJS sharedInstance] setExtraPropetries:@{@"mdtd": RN_VERSION}];

if (!_taboolas)
    _taboolas = [NSMutableArray new];
[_taboolas addObject:taboolaView];

return taboolaView;

}



- (BOOL)onItemClick:(NSString *)placementName withItemId:(NSString *)itemId withClickUrl:(NSString *)clickUrl isOrganic:(BOOL)organic
{
  NSDictionary * values = @{
@"placementName": placementName,
@"itemId": itemId,
@"clickUrl": clickUrl
};

if(organic) {
  ((RNTaboolaView *)self.taboolas.firstObject).onOrganicItemClick(values);
}
else {
  ((RNTaboolaView *)self.taboolas.firstObject).onAdItemClick(values);
}
return organic;
}

- (void)webView:(UIView*) taboolaView didFailToLoadPlacementNamed:(NSString *) placementName withErrorMessage:(NSString *) error
{
  NSDictionary * values = @{
@"placementName": placementName,
@"error": error
};
((RNTaboolaView*) taboolaView).onDidFailToLoad(values);
}

- (void)webView:(UIView*)taboolaView didLoadPlacementNamed:(NSString *) placementName withHeight:(CGFloat)height
{
  NSDictionary * values = @{
@"placementName": placementName,
@"height": [NSNumber numberWithFloat:height]
};
((RNTaboolaView*) taboolaView).onDidLoad(values);
}

@end
