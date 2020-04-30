//
// RNTaboolaView.m
// RNTaboola
//
// Created by Julian Gutierrez on 7 / 22 / 18.
// Copyright © 2018 Facebook. All rights reserved.
//

#import "RNTaboolaView.h"
@implementation RNTaboolaView

    - (BOOL)canLoadPage {
  return self.publisher && self.mode && self.pageUrl && self.pageType && self.placement;
}

- (void)setViewID:(NSString *)viewID{
  _viewID = viewID;
}

- (void)setPublisher : (NSString *)publisher{
  _publisher = publisher;
  if ([self canLoadPage])
[self fetchContent];
}

- (void)setMode : (NSString *)mode{
  _mode = mode;
  if ([self canLoadPage])
[self fetchContent];
}

- (void)setPageUrl : (NSString *)pageUrl{
  _pageUrl = pageUrl;
  if ([self canLoadPage])
[self fetchContent];
}

- (void)setPageType : (NSString *)pageType{
  _pageType = pageType;
  if ([self canLoadPage])
[self fetchContent];
}

- (void)setScrollEnabled : (BOOL)scrollEnabled{
  _scrollEnabled = scrollEnabled;
  self.scrollView.scrollEnabled = scrollEnabled;
}

- (void)setInterceptScroll : (BOOL)interceptScroll{
  _interceptScroll = interceptScroll;
}

- (void)setPlacement : (NSString *)placement{
  _placement = placement;
  if ([self canLoadPage])
[self fetchContent];
}

- (void)fetchContent{

NSString * targetType = self.targetType ? : @"mix";
NSString * viewID = self.viewID ? : @"new Date().getTime()";

NSString * htmlString = @"<html><head><meta name='viewport' content='width=device-width, user-scalable=no' /><script type='text/javascript'>!function (e, f, u, i) {if (!document.getElementById(i)){e.async = 1;e.src = u;e.id = i;f.parentNode.insertBefore(e, f);}}(document.createElement('script'),document.getElementsByTagName('script')[0],'https://cdn.taboola.com/libtrc/%@-app/mobile-loader.js','tb-mobile-loader-script');</script></head><body><div id='taboolacontainer'></div><script type='text/javascript'>window._taboola = window._taboola || [];_taboola.push({article: 'auto',url: '%@'});_taboola.push({mode: '%@',container: 'taboolacontainer',placement: '%@',target_type: '%@'});_taboola['mobile'] = [];_taboola['mobile'].push({taboola_view_id:%@,publisher:'%@'});_taboola.push({flush: true});</script></body></html>";

NSString * htmlTemplate =[NSString stringWithFormat : htmlString, self.publisher, self.pageUrl, self.mode, self.placement, targetType, viewID, self.publisher];
[self loadHTMLString : htmlTemplate baseURL :[NSURL URLWithString :@"http://cdn.taboola.com/mobile-sdk/init/"]];
}

@end