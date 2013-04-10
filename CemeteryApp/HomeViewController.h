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
#import "PoemImageView.h"


@interface HomeViewController : UIViewController 

@property (strong, nonatomic) IBOutlet SlideShowScrollView *ssScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet PoemImageView *poemImageView;

@end
