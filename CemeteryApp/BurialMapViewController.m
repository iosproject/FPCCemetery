//
//  BurialMapViewController.m
//  CemeteryApp
//
//  Created by Joshua Lisojo on 3/12/13.
//  Copyright (c) 2013 KeanU. All rights reserved.
//

#import "BurialMapViewController.h"

#define BURIAL_MAP @"BurialMap.png"

@interface BurialMapViewController ()

@end

@implementation BurialMapViewController

@synthesize mapScrollView = _mapScrollView,
            imageView = _imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.mapScrollView.delegate = self;
    self.mapScrollView.contentSize = self.imageView.image.size;
    self.imageView.frame = CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.height);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


@end
