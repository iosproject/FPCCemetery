//
//  ImageGalleryViewController.m
//  CemeteryApp
//
//  Created by Carlos Silva on 10/8/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import "ImageGalleryViewController.h"

@interface ImageGalleryViewController ()

@end

@implementation ImageGalleryViewController

@synthesize imageView = _imageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [self setImageView:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
