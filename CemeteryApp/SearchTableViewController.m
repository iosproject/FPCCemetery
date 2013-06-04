//
//  SearchTableViewController.m
//  BurialSearch
//
//  Created by Joshua Lisojo on 3/6/13.
//  Copyright (c) 2013 Lisojo. All rights reserved.
//

#import "SearchTableViewController.h"
#import "TombDetailViewController.h"
#import "QuartzCore/QuartzCore.h"
#include <sys/xattr.h>
#import "Tomb.h"

#define LATEST_TOMB_DB_URL @"http://fpcenj.org/FPCENJ/AppDB/new_tomb_database.json"
#define BACKGROUND_QUEUE dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define TOMB_DB_FILE @"tomb_db_file.json"

@interface SearchTableViewController ()
{
    NSURL *url;
}

@end

@implementation SearchTableViewController

@synthesize tombArray = _tombArray,
            searchBar = _searchBar,
            activityView = _activityView,
            loadingView = _loadingView,
            loadingLabel = _loadingLabel,
            filteredTombArray = _filteredTombArray;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // config the search bar.
    [_searchBar setShowsScopeBar:NO];
    [_searchBar sizeToFit];
    
    // Hide the search bar until user scrolls up.
    CGRect newBounds = self.tableView.bounds;
    newBounds.origin.y = newBounds.origin.y + _searchBar.bounds.size.height;
    self.tableView.bounds = newBounds;
    
    // read JSON file
    [self showLoadingView];
    [self readJSONData];
    
    // initialize the array to hold search results.
    _filteredTombArray = [NSMutableArray arrayWithCapacity:[_tombArray count]];
}

- (NSData *) getLocalDBData
{
    NSFileManager *filemgr;
    NSString *dataFile;
    NSString *docsDir;
    NSArray *dirPaths;
    NSData *data;
    
    filemgr = [NSFileManager defaultManager];
    
    // Identify the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the data file
    dataFile = [docsDir stringByAppendingPathComponent: TOMB_DB_FILE];
    
    // Check if the file already exists
    if ([filemgr fileExistsAtPath: dataFile])
    {
        // Read file contents
        data = [filemgr contentsAtPath: dataFile];
    }
    
    return data;
}


- (void)downloadFileAndSave
{
    //NSLog(@"downloading...");
    NSString *stringURL = LATEST_TOMB_DB_URL;
    
    //NSURL  *url = [NSURL URLWithString:stringURL];
    url = [NSURL URLWithString:stringURL];
    
    // add the skip backup attribute
    //[self addSkipBackupAttributeToItemAtURL:url];
    
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    
    if(urlData)
    {
        NSFileManager *filemgr;
        NSString *dataFile;
        NSString *docsDir;
        NSArray *dirPaths;
        
        filemgr = [NSFileManager defaultManager];
        dirPaths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
        docsDir = [dirPaths objectAtIndex:0];
        dataFile = [docsDir stringByAppendingPathComponent: TOMB_DB_FILE];
        NSLog(@"%@", dataFile);
        url = [NSURL fileURLWithPath:dataFile];
        [self addSkipBackupAttributeToItemAtURL:url];
        
        [filemgr createFileAtPath: dataFile contents: urlData attributes:nil];
    }
}

-(bool)isFileModified:(NSURL *)fileURL forFile:(NSString *)filePath
{
    // create a HTTP request to get the file information from the web server
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:fileURL];
    [request setHTTPMethod:@"HEAD"];
    
    NSHTTPURLResponse* response;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    // get the last modified info from the HTTP header
    NSString* httpLastModified = nil;
    if ([response respondsToSelector:@selector(allHeaderFields)])
    {
        httpLastModified = [[response allHeaderFields] objectForKey:@"Last-Modified"];
    }
    
    // setup a date formatter to query the server file's modified date
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"EEE',' dd MMM yyyy HH':'mm':'ss 'GMT'";
    df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    df.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    
    // get the file attributes to retrieve the local file's modified date
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary* fileAttributes = [fileManager attributesOfItemAtPath:filePath error:nil];
    
    // test if the server file's date is later than the local file's date
    NSDate* serverFileDate = [df dateFromString:httpLastModified];
    NSDate* localFileDate = [fileAttributes fileModificationDate];
    
    //NSLog(@"Local File Date: %@ Server File Date: %@", localFileDate, serverFileDate);
    
    //If file doesn't exist, download it
    if(localFileDate==nil){
        return YES;
    }
    
    return ([localFileDate laterDate:serverFileDate] == serverFileDate);
}

#define urlString @"http://www.google.com"

- (BOOL)connectedToInternet
{
    NSString *URLString = nil;
    NSError *error = nil;
    URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString]
                                         encoding:NSUTF8StringEncoding
                                            error:&error];
    
    return URLString != nil;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	// Update the filtered array based on the search text and scope.
	
    // Remove all objects from the filtered search array
	[self.filteredTombArray removeAllObjects];
    
	// Filter the array using NSPredicate
    NSPredicate *predicate;
    NSArray *tempArray;
    
    if([scope isEqualToString:@"Name"])
    {
        predicate = [NSPredicate predicateWithFormat:@"(fullName CONTAINS[cd] %@) OR (firstAndLastName CONTAINS[cd] %@)", searchText, searchText];
        tempArray = [_tombArray filteredArrayUsingPredicate:predicate];
    }
    else if ([scope isEqualToString:@"Y.O.D."])
    {
        predicate = [NSPredicate predicateWithFormat:@"(deathDate CONTAINS[cd] %@)", searchText];
        tempArray = [_tombArray filteredArrayUsingPredicate:predicate];
    }
    else if ([scope isEqualToString:@"Age"])
    {
        predicate = [NSPredicate predicateWithFormat:@"(years CONTAINS[cd] %@)", searchText];
        tempArray = [_tombArray filteredArrayUsingPredicate:predicate];
    }
    else if ([scope isEqualToString:@"Section"])
    {
        predicate = [NSPredicate predicateWithFormat:@"(section CONTAINS[cd] %@)", searchText];
        tempArray = [_tombArray filteredArrayUsingPredicate:predicate];
    }
    
    _filteredTombArray = [NSMutableArray arrayWithArray:tempArray];
}

- (void) readJSONData
{
    dispatch_async(BACKGROUND_QUEUE, ^{
        
        NSData *data = nil;
        /**
        // get data from internet
        if ([self connectedToInternet])
        {
            //NSLog(@"connected to internet");
            
            // DB URL
            //NSURL *url = [NSURL URLWithString:LATEST_TOMB_DB_URL];
            url = [NSURL URLWithString:LATEST_TOMB_DB_URL];
            
            // build DB local file path
            NSString *dataFile;
            NSString *docsDir;
            NSArray *dirPaths;
            
            // Identify the documents directory
            dirPaths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
            docsDir = [dirPaths objectAtIndex:0];
            
            
            // Build the path to the data file
            dataFile = [docsDir stringByAppendingPathComponent: TOMB_DB_FILE];
            
            // if the file on the server was modified dowload it, save it, and read it
            if ([self isFileModified:url forFile:dataFile]) {
                //NSLog(@"connected to internet, file was modified");
                [self downloadFileAndSave];
                data = [self getLocalDBData];
            }
            // else the file on the server wasn't modified jus read it from local file
            else
            {
                //NSLog(@"connected to internet, file was not modified");
                data = [self getLocalDBData];
            }
        }
        // else there is no internet connection try getting the DB data from a previous local file
        else {
            //NSLog(@"not connected to internet, using latest local file");
            data = [self getLocalDBData];
        }
        
        // if no data from internet and no data from downloaded local file read from default DB
        if (!data) {
            //NSLog(@"not connected to internet, using default DB");
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"default_tomb_db" ofType:@"json"];
            data = [NSData dataWithContentsOfFile:filePath];
        }
        */
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"default_tomb_db" ofType:@"json"];
        data = [NSData dataWithContentsOfFile:filePath];
        
        // create a dictionary from the DB data
        NSError *error = nil;
        NSDictionary *jsonTombData = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:&error];
        
        // ceate tomb objects from the dictionary
        [self performSelectorOnMainThread:@selector(buildTombObjectsFromDictionary:) withObject:jsonTombData waitUntilDone:YES];

    });
}

////////////////////////////////////////////////////////////////////
- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    const char* filePath = [[URL path] fileSystemRepresentation];
    
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    
    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    return result == 0;
    /**
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;*/
}

-(void)buildTombObjectsFromDictionary:(NSDictionary *)jsonTombData
{
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
 
    for (NSDictionary *dict in jsonTombData)
    {
        Tomb *tomb = [[Tomb alloc]initWithFirstName:[dict objectForKey:FPC_TOMB_FIRSTNAME]
                                        andLastName:[dict objectForKey:FPC_TOMB_LASTNAME]
                                      andMiddleName:[dict objectForKey:FPC_TOMB_MIDDLENAME]
                                       andBirthDate:([[dict objectForKey:FPC_TOMB_DOB] isEqualToString:@""]) ? @"n/a " : [dict objectForKey:FPC_TOMB_DOB]
                                       andDeathDate:([[dict objectForKey:FPC_TOMB_DOD] isEqualToString:@""]) ? @"n/a " : [dict objectForKey:FPC_TOMB_DOD]
                                          andPrefix:[dict objectForKey:FPC_TOMB_PREFIX]
                                          andSuffix:[dict objectForKey:FPC_TOMB_SUFFIX]
                                            andTour:[dict objectForKey:FPC_TOMB_TOUR]
                                        andInternet:[dict objectForKey:FPC_TOMB_INTERNETLINK]
                                           andNotes:[dict objectForKey:FPC_TOMB_NOTES]
                                    andSextonsNotes:[dict objectForKey:FPC_TOMB_NOTES]
                                         andEpitaph:[dict objectForKey:FPC_TOMB_EPITAPH]
                                         andSection:[dict objectForKey:FPC_TOMB_SECTION]
                                        andMaterial:[dict objectForKey:FPC_TOMB_MATERIAL]
                                           andYears:([[dict objectForKey:FPC_TOMB_YEARS] isEqualToString:@""]) ? @"n/a " : [dict objectForKey:FPC_TOMB_YEARS]
                                          andMonths:([[dict objectForKey:FPC_TOMB_MONTHS] isEqualToString:@""]) ? @"n/a " : [dict objectForKey:FPC_TOMB_MONTHS]
                                         andVeteran:[dict objectForKey:FPC_TOMB_VETERAN]
                                        andUniqueId:[dict objectForKey:FPC_TOMB_UID]
                                        andStanding:[dict objectForKey:FPC_TOMB_STANDING]
                                            andPoem:[dict objectForKey:FPC_TOMB_POEM]
                                             andWar:[dict objectForKey:FPC_TOMB_WAR]
                                           andApDob:[dict objectForKey:FPC_TOMB_APDOB]
                                    andCauseOfDeath:[dict objectForKey:FPC_TOMB_CAUSE_OF_DEATH]
                                       andHeadstone:[dict objectForKey:FPC_TOMB_HEADSTONE]
                                     andDateCreated:[dict objectForKey: FPC_TOMB_DATE_CREATED]
                                    andDateModified:[dict objectForKey:FPC_TOMB_DATE_MODIFIED]];
        
        [tempArray addObject:tomb];
        //NSLog(@"%@ %@", tomb.uniqueId, tomb.lastName);
    }
    
    self.tombArray = [[NSArray alloc]initWithArray:tempArray];
    [[self tableView] reloadData];
    [self hideLoadingView];

}

-(IBAction)goToSearch:(id)sender
{
    [_searchBar becomeFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [_filteredTombArray count];
    } else {
        return [_tombArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TombCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    Tomb *tomb = nil;
    
    // selecct the tombs
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        tomb = [self.filteredTombArray objectAtIndex:indexPath.row];
    } else {
        tomb = [self.tombArray objectAtIndex:indexPath.row];
    }
     
    // configure the srtings
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
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowTombDetails"])
    {
        TombDetailViewController *tombDetailViewController = [segue destinationViewController];
        
        // In order to manipulate the destination view controller, another check on which table (search or normal) is displayed is needed
        if([self.searchDisplayController isActive]) {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            Tomb *destinationTomb = [self.filteredTombArray objectAtIndex:[indexPath row]];
            [tombDetailViewController setSelectedTomb:destinationTomb];
        }
        else {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            Tomb *destinationTomb = [self.tombArray objectAtIndex:[indexPath row]];
            [tombDetailViewController setSelectedTomb:destinationTomb];
        }
    }
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (void) hideLoadingView
{
    [_activityView stopAnimating];
    [_loadingView removeFromSuperview];
}

- (void) showLoadingView
{
    _loadingView = [[UIView alloc] initWithFrame:CGRectMake(75, 155, 170, 170)];
    _loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0.25 alpha:0.25];
    _loadingView.layer.borderColor = [[UIColor blueColor] CGColor];
    _loadingView.clipsToBounds = YES;
    _loadingView.layer.cornerRadius = 10.0;

    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityView.frame = CGRectMake(65, 40, _activityView.bounds.size.width, _activityView.bounds.size.height);
    [_loadingView addSubview:_activityView];

    _loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 115, 130, 22)];
    _loadingLabel.backgroundColor = [UIColor clearColor];
    _loadingLabel.textColor = [UIColor whiteColor];
    _loadingLabel.adjustsFontSizeToFitWidth = YES;
    _loadingLabel.textAlignment = NSTextAlignmentCenter;
    _loadingLabel.text = @"Loading...";
    [_loadingView addSubview:_loadingLabel];
    
    [self.view addSubview:_loadingView];
    [_activityView startAnimating];
}

@end
