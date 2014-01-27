//
//  UISearchDisplayController+RAC.h
//  ReactiveCocoaExample
//
//  Created by Justin DeWind on 1/26/14.
//  Copyright (c) 2014 Justin DeWind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchDisplayController (RAC)
- (RACSignal *)rac_isActiveSignal;
@end
