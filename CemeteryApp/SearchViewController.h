//
//  SearchViewController.h
//  CemeteryApp
//  Created by student on 9/24/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TombDataManager.h"

// comment
@interface SearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIPopoverControllerDelegate, UIActionSheetDelegate> // FilterViewDelegate
{
    

}

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (nonatomic, retain) NSString *searchString;
@property (strong, nonatomic) UIButton *filterButton;
@property (strong, nonatomic) UIActionSheet *filterActionSheet;
@property (strong, nonatomic) NSString *filterString;
@property (strong, nonatomic) TombDataManager *tombDM;

-(IBAction)filterButton:(id)sender;
+(SearchViewController *)instance;
-(void)refresh;

@end
