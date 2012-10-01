//
//  CemeteryAppViewController.m
//  CemeteryApp
//
//  Created by student on 9/24/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import "HomeViewController.h"
#import "TransitionImageView.h"

@interface HomeViewController ()

@end

@implementation HomeViewController


@synthesize imageView = _imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    _imageView.animationImages = [NSArray arrayWithObjects:
                                  [UIImage imageNamed:@"ss_img1.png"],
                                  [UIImage imageNamed:@"ss_img2.png"],
                                  [UIImage imageNamed:@"ss_img3.png"], nil];
    _imageView.animationDuration = 12.00; //12 second
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
