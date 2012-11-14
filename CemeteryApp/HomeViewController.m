//
//  CemeteryAppViewController.m
//  CemeteryApp
//
//  Created by student on 9/24/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation HomeViewController

@synthesize imageView = _imageView;
@synthesize textView = _textView;
@synthesize images = _images;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setupSlideshow];
}

- (void)setupSlideshow
{
    _imageView.animationImages = [NSArray arrayWithObjects:
                                  [UIImage imageNamed:@"ssimage00.png"],
                                  [UIImage imageNamed:@"ssimage01.png"],
                                  [UIImage imageNamed:@"ssimage02.png"],
                                  [UIImage imageNamed:@"ssimage03.png"],
                                  [UIImage imageNamed:@"ssimage04.png"],nil];
    _imageView.animationDuration = 25.00; // seconds
    _imageView.animationRepeatCount = 0; //infinite
    [self startSlideshow];
    
}

- (void)startSlideshow
{
    [_imageView startAnimating]; //start the animation
}

-(void)viewWillAppear:(BOOL)animated
{
    [self startSlideshow];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_imageView stopAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
