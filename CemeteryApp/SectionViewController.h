//
//  SectionViewController.h
//  CemeteryApp
//
//  Created by Computer Science on 4/10/13.
//  Copyright (c) 2013 KeanU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionViewController : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *sectionImageView;
@property (strong, nonatomic) IBOutlet UIScrollView *sectionScrollView;
@property (strong, nonatomic) NSString *section;

@property (nonatomic, retain) UIActivityIndicatorView * activityView;
@property (nonatomic, retain) UIView *loadingView;
@property (nonatomic, retain) UILabel *loadingLabel;
@end
