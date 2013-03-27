//
//  CemeteryAppViewController.h
//  CemeteryApp
//
//  Created by student on 9/24/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "SlideShowScrollView.h"

@interface HomeViewController : UIViewController <UIScrollViewDelegate> 

@property (strong, nonatomic) IBOutlet SlideShowScrollView *ssScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end
