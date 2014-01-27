//
//  UISearchDisplayController+RAC.m
//  ReactiveCocoaExample
//
//  Created by Justin DeWind on 1/26/14.
//  Copyright (c) 2014 Justin DeWind. All rights reserved.
//

#import "UISearchDisplayController+RAC.h"
#import <objc/objc-runtime.h>

@interface UISearchDisplayController()<UISearchDisplayDelegate>

@end

@implementation UISearchDisplayController (RAC)
- (RACSignal *)rac_isActiveSignal {
    self.delegate = self;
    RACSignal *signal = objc_getAssociatedObject(self, _cmd);
    if (signal != nil) return signal;
    
    RACSignal *didBeginEditing = [[self rac_signalForSelector:@selector(searchDisplayControllerDidBeginSearch:) fromProtocol:@protocol(UISearchDisplayDelegate)] mapReplace:@YES];
    RACSignal *didEndEditing = [[self rac_signalForSelector:@selector(searchDisplayControllerDidEndSearch:) fromProtocol:@protocol(UISearchDisplayDelegate)] mapReplace:@NO];
    signal = [RACSignal merge:@[didBeginEditing, didEndEditing]];
    objc_setAssociatedObject(self, _cmd, signal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return signal;
}
@end
