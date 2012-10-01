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


@synthesize imageView = _imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _imageView.animationImages = [NSArray arrayWithObjects:
                                  [UIImage imageNamed:@"img1.JPG"],
                                  [UIImage imageNamed:@"img2.JPG"],
                                  [UIImage imageNamed:@"img3.JPG"], nil];
    _imageView.animationDuration = 15.00; //1 second
    _imageView.animationRepeatCount = 0; //infinite
    
    [_imageView startAnimating]; //start the animation
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [super viewDidUnload];
}
@end
