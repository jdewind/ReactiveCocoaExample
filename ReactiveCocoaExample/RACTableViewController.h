//
//  RACViewController.h
//  ReactiveCocoaExample
//
//  Created by Justin DeWind on 1/26/14.
//  Copyright (c) 2014 Justin DeWind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UISearchBar+RAC.h"
#import "UISearchDisplayController+RAC.h"

@interface RACTableViewController : UITableViewController
@property(nonatomic, retain) UISearchBar *searchBar;
@property(nonatomic, copy) NSArray *searchTexts;
@property(nonatomic, copy) NSArray *searchResults;
@property(nonatomic, retain) UISearchDisplayController *searchController;
@property(nonatomic, assign, getter = isSearching) BOOL searching;
@end
