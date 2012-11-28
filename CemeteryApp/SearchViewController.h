//
//  SearchViewController.h
//  CemeteryApp
//  Created by student on 9/24/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterViewController.h"
// comment
@interface SearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIPopoverControllerDelegate, UIActionSheetDelegate> // FilterViewDelegate
{
    

}

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (nonatomic, retain) NSString *searchString;
@property (strong, nonatomic) UIButton *filterButton;
@property (strong, nonatomic) FilterViewController *filterPicker;
@property (strong, nonatomic) IBOutlet FilterViewController *filter;
@property (strong, nonatomic) UIActionSheet *filterActionSheet;
@property (strong, nonatomic) NSString *filterString;

-(IBAction)filterButton:(id)sender;
@end
