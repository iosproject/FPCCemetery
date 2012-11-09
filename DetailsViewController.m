//
//  DetailsViewController.m
//  CemeteryApp
//
//  Created by Joshua Lisojo on 11/8/12.
//  Copyright (c) 2012 KeanU. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

@synthesize selectedIndex, selectedTomb;
@synthesize textView = _textView;

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

    [_textView setText: [NSString stringWithFormat:@"\nDate of Birth: %@\nDate of Death: %@\nLocation: %@\n\nEpitaph: %@", selectedTomb[@"DOB"], selectedTomb[@"DOD"], selectedTomb[@"Section"], selectedTomb[@"Epitaph"]]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setTitle:[NSString stringWithFormat:@"%@ %@", selectedTomb[@"FirstName"], selectedTomb[@"LastName"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTextView:nil];
    [super viewDidUnload];
}
@end
