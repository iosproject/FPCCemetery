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
@synthesize textView = _textView;
@synthesize recognizer = _recognizer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"View Loaded");
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom)];
    swipe.numberOfTouchesRequired = 1;
    
    [self.imageView addGestureRecognizer:swipe];
    
    // use the imageview animation to slide images
    _imageView.animationImages = [NSArray arrayWithObjects:
                                  [UIImage imageNamed:@"ss_img1.png"],
                                  [UIImage imageNamed:@"ss_img2.png"],
                                  [UIImage imageNamed:@"ss_img3.png"], nil];
    _imageView.animationDuration = 12.00; //12 second
    _imageView.animationRepeatCount = 0; //infinite
    [_imageView startAnimating]; //start the animation    
}

- (IBAction)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{    
	NSLog(@"Swipe Recognized");
    
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        
    }
    else {
        
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setTextView:nil];
    [self setRecognizer:nil];
    [super viewDidUnload];
}

@end
