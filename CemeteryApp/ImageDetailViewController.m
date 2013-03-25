//
//  ImageDetailViewController.m
//  CemeteryApp
//
//  Created by Joshua Lisojo on 2/22/13.
//  Copyright (c) 2013 KeanU. All rights reserved.
//

#import "ImageDetailViewController.h"

@interface ImageDetailViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ImageDetailViewController

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
	// Do any additional setup after loading the view.
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.imageView.image = self.image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setImage:nil];
    [self setImageView:nil];
    //[self setZoom:nil];
    [super viewDidUnload];
}

- (IBAction)didSwipeLeft:(id)sender {
    //self.imageView.image = [self nextImage];
    self.imageIndex++;
    if(self.imageIndex >= self.imageArray.count)
        self.imageIndex = 0;
    self.imageView.image = [UIImage imageNamed:self.imageArray[self.imageIndex]];
}

- (IBAction)didSwipeRight:(id)sender {
    //self.imageView.image = [self previousImage];
    self.imageIndex--;
    if(self.imageIndex < 0)
        self.imageIndex = self.imageArray.count - 1;
    self.imageView.image = [UIImage imageNamed:self.imageArray[self.imageIndex]];
}

@end
