//
//  SearchViewController.h
//  CemeteryApp
//  Created by student on 9/24/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import <UIKit/UIKit.h>
// comment
@interface SearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
{
    //NSString *searchString;

}

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (nonatomic, retain) NSString *searchString;
@property (strong, nonatomic) NSMutableArray *displayArray;
@end
