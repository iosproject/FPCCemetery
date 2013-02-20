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

@end

@implementation SearchViewController

@synthesize searchTableView = _searchTableView;
@synthesize searchBar = _searchBar;
@synthesize searchString;
@synthesize filterButton;
@synthesize filterActionSheet;
@synthesize filterString;

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
    self.filterString = @"All";
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //code executed in the background
//        
//        NSData* tombData = nil;
//        
//        // read data from online source
//        tombData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://eve.kean.edu/~jplisojo/result2.json"]];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[TombDataManager instance]filterTombs:searchString withFilter:filterString]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"name cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    Tomb *tomb = [[[TombDataManager instance]filterTombs:searchString withFilter:filterString]objectAtIndex:indexPath.row];
    if([tomb.middleName isEqual:nil] || [tomb.middleName isEqual:NULL] || [tomb.middleName isEqualToString:@""])
    {
        cell.textLabel.text = [NSString stringWithFormat: @"%@ %@", tomb.firstName, tomb.lastName, nil];
    }
    else
    {
        if([tomb.middleName length] == 1)
        {
            tomb.middleName = [tomb.middleName stringByAppendingString:@"."];
        }
        cell.textLabel.text = [NSString stringWithFormat: @"%@ %@ %@", tomb.firstName, tomb.middleName ,tomb.lastName, nil];
    }
    

    if(![tomb.birthDate isEqualToString:@""] && ![tomb.deathDate isEqualToString:@""])
    {
        cell.detailTextLabel.text = [NSString stringWithFormat: @"%@ - %@", [tomb.birthDate substringToIndex:4], [tomb.deathDate substringToIndex:4], nil];
    }
    else
    {
        cell.detailTextLabel.text = @"";
    }
    
    // Configure the cell.
    return cell;
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [searchBar setShowsCancelButton:NO animated:YES];
    self.searchTableView.allowsSelection = YES;
    self.searchTableView.scrollEnabled = YES;
    [self updateSearchString:searchBar.text];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Details"])
    {
        DetailsViewController *vc = [segue destinationViewController];
        NSInteger selectedIndex = [[self.searchTableView indexPathForSelectedRow] row];
        //[vc setSelectedTomb: [[[TombDataManager instance]tombs]objectAtIndex:selectedIndex]];
        [vc setSelectedTomb:[[[TombDataManager instance]filterTombs:searchString withFilter:filterString]objectAtIndex:selectedIndex]];
    }
}

- (void)updateSearchString:(NSString*)aSearchString
{
    searchString = [[NSString alloc]initWithString:aSearchString];
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
    [self.searchBar resignFirstResponder];
    [self.searchBar setShowsCancelButton:NO animated:YES];
    self.searchTableView.allowsSelection = YES;
    self.searchTableView.scrollEnabled = YES;
    [self updateSearchString:searchBar.text];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    self.searchTableView.allowsSelection = NO;
    self.searchTableView.scrollEnabled = NO;
    [self updateSearchString:searchBar.text];
}

- (void)viewDidUnload
{
    [self setSearchBar:nil];
    [self setSearchTableView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)filterButton:(id)sender
{
    [self.searchBar resignFirstResponder];
    
    filterActionSheet = [[UIActionSheet alloc] initWithTitle:@"Search Filter"
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                      destructiveButtonTitle:nil
                                           otherButtonTitles:@"All", @"Name",@"Date of Birth", @"Date of Death", @"Section", @"Age", nil];
    [self.filterActionSheet showFromTabBar:self.tabBarController.tabBar];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        self.filterString = @"All";
    }
    else if (buttonIndex == 1)
    {
        self.filterString = @"Name";
    }
    else if (buttonIndex == 2)
    {
        self.filterString = @"Date of Birth";
    }
    else if (buttonIndex == 3)
    {
        self.filterString = @"Date of Death";
    }
    else if (buttonIndex == 4)
    {
        self.filterString = @"Section";
    }
    else
    {
        self.filterString = @"Years";
    }
    self.title = [NSString stringWithFormat:@" Search - %@",self.filterString];
}

@end

