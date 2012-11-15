//
//  FilterViewController.m
//  CemeteryApp
//
//  Created by Computer Science on 11/15/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()

@end

@implementation FilterViewController

@synthesize filterArray;
@synthesize delegate;

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
    self.clearsSelectionOnViewWillAppear = NO;
    self.filterArray = [NSMutableArray array];
    [filterArray addObject:@"All"];
    [filterArray addObject:@"Name"];
    [filterArray addObject:@"Section"];
    [filterArray addObject:@"Date of Birth"];
    [filterArray addObject:@"Date of Death"];
    [filterArray addObject:@"Years"];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidUnload
{
    [super viewDidUnload];
    self.filterArray = nil;
    self.delegate = nil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [filterArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"name cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSString *filterOption = [filterArray objectAtIndex:indexPath.row];
    cell.textLabel.text = filterOption;
    
    // Configure the cell.
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (delegate != nil) {
        NSString *filterOption = [filterArray objectAtIndex:indexPath.row];
        [delegate filterSelected:filterOption];
    }
}
@end
