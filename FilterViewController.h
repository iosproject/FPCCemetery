//
//  FilterViewController.h
//  CemeteryApp
//
//  Created by Computer Science on 11/15/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FilterViewDelegate
- (void)filterSelected:(NSString *)filter;
@end

@interface FilterViewController : UITableViewController
{
    NSMutableArray *filterArray;
}

@property (nonatomic, retain) NSMutableArray *filterArray;
@property (nonatomic, assign) id<FilterViewDelegate> delegate;
@end
