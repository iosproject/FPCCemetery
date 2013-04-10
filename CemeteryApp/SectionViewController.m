//
//  SectionViewController.m
//  CemeteryApp
//
//  Created by Computer Science on 4/10/13.
//  Copyright (c) 2013 KeanU. All rights reserved.
//

#import "SectionViewController.h"

@interface SectionViewController ()

@end

@implementation SectionViewController

@synthesize sectionImageView = _sectionImageView,
            section = _section;

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
    [self fetchSectionImage];
}

- (void)fetchSectionImage
{
    NSString *stringURL = [NSString stringWithFormat: @"http://fpcenj.org/FPCENJ/app_images/section_images/section_%@.jpeg", [_section substringToIndex:1], nil];
    
    NSLog(@"%@", stringURL);

    NSURL *url = [NSURL URLWithString:stringURL];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    [_sectionImageView setImage:image];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
