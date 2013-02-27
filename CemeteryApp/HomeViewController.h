//
//  CemeteryAppViewController.h
//  CemeteryApp
//
//  Created by student on 9/24/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UIScrollViewDelegate> 

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView2;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) NSArray *imgViews;
@property (nonatomic, retain) NSTimer *timer;
@property (strong, nonatomic) UIAlertView *databaseCheckAlertView;
@property (strong, nonatomic) UIActivityIndicatorView *loading;
@end
