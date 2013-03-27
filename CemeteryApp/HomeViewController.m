//
//  CemeteryAppViewController.m
//  CemeteryApp
//
//  Created by student on 9/24/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import "HomeViewController.h"
@interface HomeViewController ()


@end


@implementation HomeViewController
@synthesize ssScrollView = _ssScrollView,
            pageControl = _pageControl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Setup the slideshow and reference the page control.
    [_ssScrollView setupSlideShow];
    [_ssScrollView setPageControl:_pageControl];
}

@end
