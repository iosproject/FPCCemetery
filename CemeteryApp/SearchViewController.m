//
//  SearchViewController.m
//  CemeteryApp
//
//  Created by student on 9/24/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import "SearchViewController.h"
#import "DetailsViewController.h"

@interface SearchViewController ()
{
    NSMutableArray *jsonData;
}

@end

@implementation SearchViewController

@synthesize searchTableView = _searchTableView;
@synthesize searchBar = _searchBar;


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
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //code executed in the background
        
        NSData* tombData = nil;
        
        // read data from online source
        tombData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://eve.kean.edu/~jplisojo/result.json"]];
        
        if (!tombData) {
            // read data from local file
            NSLog(@"Local DB");
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"result" ofType:@"json"];
            NSError *error = nil;
            tombData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
        }
        
        // fetch the data
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:tombData waitUntilDone:YES];
    });
}

#define dbName @"Tombs"

- (void)fetchedData:(NSData *)responseData
{
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData
                                                         options:kNilOptions
                                                           error:&error];
    jsonData = [json objectForKey:dbName];
    [self.searchTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [jsonData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"name cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    NSDictionary *tombDict = [jsonData objectAtIndex:indexPath.row];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat: @"%@ %@", [tombDict objectForKey:@"FirstName"], [tombDict objectForKey:@"LastName"], nil];
    cell.detailTextLabel.text = [NSString stringWithFormat: @"%@", [tombDict objectForKey:@"DOD"], nil];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Details"])
    {
        DetailsViewController *vc = [segue destinationViewController];
        NSInteger selectedIndex = [[self.searchTableView indexPathForSelectedRow] row];
        [vc setSelectedTomb: [jsonData objectAtIndex:selectedIndex]];
    }

}



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

@end

