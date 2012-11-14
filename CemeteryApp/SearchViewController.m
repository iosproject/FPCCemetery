//
//  SearchViewController.m
//  CemeteryApp
//
//  Created by student on 9/24/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import "SearchViewController.h"
#import "DetailsViewController.h"
#import "Tomb.h"
#import "TombDataManager.h"

@interface SearchViewController ()
//{
//    NSMutableArray *jsonData;
//    NSDictionary *json;
//    NSArray *tombs;
//}
//
//@property (readonly) NSArray *tombs;
//@property (readonly) NSDictionary *json;
@end

@implementation SearchViewController

@synthesize searchTableView = _searchTableView;
@synthesize searchBar = _searchBar;
//@synthesize tombs, json;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //code executed in the background
//        
//        NSData* tombData = nil;
//        
//        // read data from online source
//        tombData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://eve.kean.edu/~jplisojo/result.json"]];
//        
//        if (!tombData) {
//            // read data from local file
//            NSLog(@"Local DB");
//            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"result" ofType:@"json"];
//            NSError *error = nil;
//            tombData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
//        }
//        
//        // fetch the data
//        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:tombData waitUntilDone:YES];
//    });
}

//#define dbName @"Tombs"
//
//- (void)fetchedData:(NSData *)responseData
//{
//    NSError *error;
//    json = [NSJSONSerialization JSONObjectWithData:responseData
//                                                         options:kNilOptions
//                                                           error:&error];
//    jsonData = [json objectForKey:dbName];
//    [self.searchTableView reloadData];
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [jsonData count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *simpleTableIdentifier = @"name cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
//    NSDictionary *tombDict = [jsonData objectAtIndex:indexPath.row];
//    
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
//    }
//    
//    cell.textLabel.text = [NSString stringWithFormat: @"%@ %@", [tombDict objectForKey:@"FirstName"], [tombDict objectForKey:@"LastName"], nil];
//    cell.detailTextLabel.text = [NSString stringWithFormat: @"%@", [tombDict objectForKey:@"DOD"], nil];
//    
//    return cell;
//}
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([[segue identifier] isEqualToString:@"Details"])
//    {
//        DetailsViewController *vc = [segue destinationViewController];
//        NSInteger selectedIndex = [[self.searchTableView indexPathForSelectedRow] row];
//        [vc setSelectedTomb: [jsonData objectAtIndex:selectedIndex]];
//    }
//
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[TombDataManager instance]filterTombsWithLastName:self.searchBar.text]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"name cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Tomb *tomb = [[[TombDataManager instance]filterTombsWithLastName:self.searchBar.text]objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat: @"%@ %@", tomb.firstName, tomb.lastName, nil];
    cell.detailTextLabel.text = [NSString stringWithFormat: @"%@", tomb.deathDate, nil];
    
    // Configure the cell.
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Details"])
    {
        DetailsViewController *vc = [segue destinationViewController];
        NSInteger selectedIndex = [[self.searchTableView indexPathForSelectedRow] row];
        [vc setSelectedTomb: [[[TombDataManager instance]tombs]objectAtIndex:selectedIndex]];
    }
    
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    self.searchTableView.allowsSelection = NO;
    self.searchTableView.scrollEnabled = NO;
}


//- (NSArray *)filterTombsWithLastName:(NSString *)lastName
//{
//    if (lastName && [lastName length] > 0)
//    {
//        NSMutableArray *filterTombs = [json allValues];
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"lastName LIKE %@", lastName];
//        [filterTombs filterUsingPredicate:predicate];
//        return filterTombs;
//    }
//    else
//    {
//        return tombs;
//    }
//}

- (void)viewDidUnload
{
    [self setSearchBar:nil];
    [self setSearchTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)updateSearchString:(NSString*)aSearchString
{
    self.searchBar.text = [[NSString alloc]initWithString:aSearchString];
    [self.searchTableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    self.searchTableView.allowsSelection = YES;
    self.searchTableView.scrollEnabled = YES;
    searchBar.text=@"";
    [self updateSearchString:searchBar.text];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //NSMutableArray *tomb = [[TombDataManager instance] tombs];
    //[tomb removeAllObjects];
    [searchBar resignFirstResponder];
    self.searchTableView.allowsSelection = YES;
    self.searchTableView.scrollEnabled = YES;
    [self updateSearchString:searchBar.text];
}

@end

