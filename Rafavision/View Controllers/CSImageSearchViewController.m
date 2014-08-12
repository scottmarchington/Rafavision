//
//  csImageSearchViewController.m
//  Rafavision
//
//  Created by Scott Marchington on 8/11/14.
//  Copyright (c) 2014 Scott Marchington. All rights reserved.
//

#import "CSImageSearchViewController.h"
#import "CSImageSearchDatasource.h"
#import "CSImageSearchResult.h"
#import "CSImageSearchResultCell.h"
#import "CSSearchHistoryCell.h"
#import "CSPastSearchHelper.h"

@interface CSImageSearchViewController ()

@property (strong, nonatomic) CSImageSearchDatasource *datasource;

@end

@implementation CSImageSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(!self.datasource)
    {
        self.datasource = [[CSImageSearchDatasource alloc] init];
    }
    
    [self.datasource newSearchForSearchTerm:@"nadal"
                                   complete:^
    {
        [self.collectionView reloadData];
    }];
    
    [self.searchDisplayController.searchResultsTableView registerNib:[CSSearchHistoryCell cellNib] forCellReuseIdentifier:[CSSearchHistoryCell reuseIdentifier]];
    self.searchDisplayController.displaysSearchBarInNavigationBar = YES;
}

#pragma mark - UICollectionViewDataSource/Delegate Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datasource.searchResults.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CSImageSearchResultCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[CSImageSearchResultCell reuseIdentifier] forIndexPath:indexPath];
    
    [cell displayImageResult:self.datasource.searchResults[indexPath.row]];
    
    if(self.datasource.searchResults.count < indexPath.row + 3)
        [self attemptLoadingMoreData];
    
    return cell;
}

#pragma mark - UISearchBarDelegate Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchTerm = searchBar.text;
    
    [self.datasource newSearchForSearchTerm:searchTerm
                                   complete:^
    {
        [self.collectionView reloadData];
    }];
    
    [self.searchDisplayController setActive:NO animated:YES];
    [[CSPastSearchHelper sharedInstance] addToPastSearchTerms:searchTerm];
}

#pragma mark - UITableViewDataSource/Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[CSPastSearchHelper sharedInstance] filteredPastSearchTermsForSearchTerm:self.searchDisplayController.searchBar.text].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSSearchHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSSearchHistoryCell reuseIdentifier]];
    
    NSArray *ourDatasource = [[CSPastSearchHelper sharedInstance] filteredPastSearchTermsForSearchTerm:self.searchDisplayController.searchBar.text];
    NSString *ourData = ourDatasource[ourDatasource.count - (1 + indexPath.row)];
    [cell displaySearchTerm:ourData];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *ourDatasource = [[CSPastSearchHelper sharedInstance] filteredPastSearchTermsForSearchTerm:self.searchDisplayController.searchBar.text];
    NSString *ourData = ourDatasource[ourDatasource.count - (1 + indexPath.row)];
    
    [self.datasource newSearchForSearchTerm:ourData
                                   complete:^
     {
         [self.collectionView reloadData];
     }];
    
    //    [self.searchDisplayController.searchBar resignFirstResponder];
    [self.searchDisplayController setActive:NO animated:YES];
    [[CSPastSearchHelper sharedInstance] addToPastSearchTerms:ourData];
}

#pragma mark - Helper Methods

- (void)attemptLoadingMoreData
{
    if(self.datasource.hasMoreData && !self.datasource.isLoading)
    {
        [self.datasource loadMoreData:^
        {
            [self.collectionView reloadData];
        }];
    }
}

@end
