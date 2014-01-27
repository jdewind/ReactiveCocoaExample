//
//  RACViewController.m
//  ReactiveCocoaExample
//
//  Created by Justin DeWind on 1/26/14.
//  Copyright (c) 2014 Justin DeWind. All rights reserved.
//

#import "RACTableViewController.h"

@interface RACTableViewController ()

@end

@implementation RACTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Example";
        self.searchTexts = @[
                             @"San Francisco",
                             @"Grand Rapids",
                             @"Chicago",
                             @"San Jose"
                             ];
        self.searchResults = @[];
    }
    return self;
}

- (NSArray *)search:(NSString *)searchText {
    NSMutableArray *results = [NSMutableArray array];
    for (NSString *text in self.searchTexts) {
        if([[text lowercaseString] rangeOfString:[searchText lowercaseString]].location != NSNotFound) {
            [results addObject:text];
        }
    }
    return results;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    [self.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchBar;
    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;
    [self.searchController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    RAC(self, searchResults) = [self rac_liftSelector:@selector(search:) withSignals:self.searchBar.rac_textSignal, nil];
    RAC(self, searching) = [[self.searchController rac_isActiveSignal] doNext:^(id x) {
        NSLog(@"Searching %@", x);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.isSearching) {
        return self.searchResults.count;
    } else {
        return self.searchTexts.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.isSearching ? self.searchResults[indexPath.row] : self.searchTexts[indexPath.row];
    return cell;
}
@end
