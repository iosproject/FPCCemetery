//
//  SearchViewController.h
//  CemeteryApp
//
//  Created by student on 9/24/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import <UIKit/UIKit.h>
// comment

#define jsonObjectURL @"http://mdevsvr/result.json";
@interface SearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
- (IBAction)getJsonData:(id)sender;
+ (BOOL)regEx:(NSString *)searchBar: (NSString *)toBeSearched;@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end
