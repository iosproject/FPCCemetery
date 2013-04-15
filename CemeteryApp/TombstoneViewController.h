//
//  TombstoneViewController.h
//  CemeteryApp
//
//  Created by Computer Science on 4/10/13.
//  Copyright (c) 2013 KeanU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TombstoneViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *tombstoneImageView;
@property (strong, nonatomic) NSString *tombstoneNumber;
@property (strong, nonatomic) IBOutlet UIScrollView *tombstoneScrollView;

@property (nonatomic, retain) UIActivityIndicatorView * activityView;
@property (nonatomic, retain) UIView *loadingView;
@property (nonatomic, retain) UILabel *loadingLabel;

@end
